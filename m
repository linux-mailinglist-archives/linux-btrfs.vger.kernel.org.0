Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754D320D6B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgF2TXO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Jun 2020 15:23:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:46563 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729336AbgF2TXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 15:23:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-7-asr9s9uFMYuh65CejR6bhg-1; Mon, 29 Jun 2020 09:21:01 +0200
X-MC-Unique: asr9s9uFMYuh65CejR6bhg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI4t4Eej8MLZJcDe6F6UYn+8HF6mbx0SmDfa8oTZQQ5KJTRxXEvqs7HVqvssgHRhFmXoifurGfzELgLLyMo5rWCbMd23N4eMIYK2E60bQ5KbsaUHD299IWUCakKRU1q/msIwTqSLCJcNh9jgn/9kkwb9unQAo5bEj08bKucIfC5vz5HkXN90A/2IqKnuO/d5YK12Fdyk4LB0Hwni9cZgJIauIAd4BLuv86hl1Lsi+fLbgwjQgy6o4cR8VnwyGeCHS15KL9HJA9MBBJppygcErBahStPN1bWj9vumau7wZlNoG82vLWocpU4iHcms8y/1M0OycJ8b/16bKJmIRKj6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfr8XwVZ68KQPqlkf0jmCqPn4WnAQs46UtGJ/TiiQwM=;
 b=hM1LtIxjBowfNM8KHAIQ7cpTwZRh5xSAzckyYGVxVNaaAcnYVj2O9UdQsjuyVPo1Zw8izFDTJuPrA+DTKj/WUzawUNEUYtKNMQtn8CC4wHbSyKlRChR5jhwjLZE9nLtpiAZD0JOJz5Fuykz8E9VXfNfH42hZFHVh37AS5Ed3udsQY+HDoWaa3zsaqNsgwEZkr4FtQqRZ3Aed9Wj1vQSCB+uOsj2WeHM4hK4Dlw3a1Oplp0BwaI2LJ3Ny3FVJnquf99I2DO35AbG4ajO6f6IrXPomITwKh/d66YFzGHHNoDr8jLcioUJzSslVX1ZLUmMw7AVVGIBqMV5S6KPBNwYt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4193.eurprd04.prod.outlook.com (2603:10a6:208:58::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 07:21:00 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 07:20:59 +0000
Subject: Re: [PATCH v6 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Anand Jain <anand.jain@oracle.com>
References: <20200628051839.63142-1-wqu@suse.com>
 <20200628051839.63142-4-wqu@suse.com>
 <SN4PR0401MB359839A2E5EA48ED5D0B2E2B9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <239aeeb4-df67-6a9b-d71e-8855404ad004@suse.com>
Date:   Mon, 29 Jun 2020 15:20:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <SN4PR0401MB359839A2E5EA48ED5D0B2E2B9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR01CA0006.prod.exchangelabs.com (2603:10b6:a02:80::19)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0006.prod.exchangelabs.com (2603:10b6:a02:80::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 07:20:56 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae91f1d9-e8ea-487a-cb72-08d81bfcf8fe
X-MS-TrafficTypeDiagnostic: AM0PR04MB4193:
X-Microsoft-Antispam-PRVS: <AM0PR04MB419300BFAB4A08C8EF090225D66E0@AM0PR04MB4193.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lffm9S7eSwWddkC0btw9RFGCZ8jbN/oYof2bS0a9BZQBvyvUVBESmZ3OOrzjp/25akoNSrHINeyscruls6AdMlALpHnKtIxx/8mbJ3lxzCkJs6Ad42HaxJSxD6/xUr0T5zAJbSeIetb6cjgSPvZTZq8u0QIcBpl/vYsiye8cpxWgB33R0jEprFMVRzJt1tpIlE8NhcLdRw672gYAGKvxdzbNr73ytXqj4d4zBHqR4rHqUFct/2RG1Xwf4yeiFkzdDPxnsC2LFPbp8OhVCSoDawHI36uNy9d83j/1imZtQkZf2UoS9hiC/WilpyDmv+IfsBVhNAGhIpHasQmcBB4hgOMs5YA+OexJoAE6t2pTervDzVdp2h42mNs98BR9oj+I+qzP9ui3acTae53lekaI4N5I7BXyCzYaXijkJdztcQedbvxC/LcUne9wtsJXb/e6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(16526019)(186003)(4326008)(31686004)(8676002)(2616005)(26005)(86362001)(956004)(31696002)(558084003)(36756003)(8936002)(53546011)(5660300002)(83380400001)(66476007)(6666004)(6706004)(66556008)(66946007)(6486002)(52116002)(478600001)(16576012)(110136005)(316002)(2906002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZDxLBBqLu75a7p30S4iRmJsIIsqvKJe6j0MVurXthGiHDVQxrYxoguUZP7ieUMAvIlCdaMCfPr/q7zyh84uoGvltLXLoWom7VGMGNaWvLJ5ZKTtqNGxpchu25PcUSBy6vWSo6N00Yu7g+uk6DdbNny3Ky5eicusDgDDwxJiqhUfsCESu7SviiSqyfL98o3RsAMYiIiRWrrEmfUsJ+SW1/we1FrArqYVdeIeynxMDBtYZGihaPuzhkQQr5lYxUXVg1YC6PZJhWnk8h+iHCJ5kEyHToJhhooAu1a7F3vbJExSVLwmvxvmGGOCBDN1U3yQYhBE7MMLPdBDlBTWJ/AWhdiAUE7OHExFRO7cF1pVSbtOiHWhxfi8kzrwsIu+xDAbyfat8VOQco7/ItN/e+3FhyfQ3D+zpmyc33CB5xdn7cbNAC2PUK+vXV/6Db2uVxYvTRKZvWw7eN3k0UhPulpDP2uAB+WBDYCnYJxZvqUqCbMg=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae91f1d9-e8ea-487a-cb72-08d81bfcf8fe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 07:20:59.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDfTkItDRDgjYipKGAsiMRSAP/qRmPh/ZOHKbL7M2oNojtSC3LnpKWUss4yjCkjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4193
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/29 下午3:13, Johannes Thumshirn wrote:
> On 28/06/2020 07:19, Qu Wenruo wrote:
>> -		btrfs_drew_write_unlock(&BTRFS_I(inode)->root->snapshot_lock);
>> +		btrfs_check_nocow_unlock(BTRF_I(inode));
> 
> Huhz?
> 
That's why there is a v7 update...

