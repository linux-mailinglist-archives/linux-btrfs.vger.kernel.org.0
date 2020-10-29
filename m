Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16829E551
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbgJ2H4T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:56:19 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:33199 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730816AbgJ2HyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1603958053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=BdNyVFKfs+Hs1HeF4uqH1G8mVozT7fWuYps69mO7h6k=;
        b=Wd2Jjn3kkBm/9X+yCW8VwzBwDnS72t0oVCHM2SG6Z3kGSv2XJILXRJHdmafAuFFJ7NZg/J
        2RsYcQP0INvMWuRMdJDyxfyjlezDekUS7BFogslGw9rM700628jUUW+TSpYf/Xg07csUng
        lP2tAThuT8DbWu5/9mq4Pxs3dgberw8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-4-xGtdSwdON6SjPL4-qRUx_w-1; Thu, 29 Oct 2020 08:54:11 +0100
X-MC-Unique: xGtdSwdON6SjPL4-qRUx_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzVD4nqOTVRCbrWnLvHXkRaV1TOcj1xkx1NJqMiQ866FXdrbiqm82DcEKtfvrKz7w5fahf9R3Tq/hHKFvsekk9oRcZsCdcwoWzEVd7iQZnT+QxeRoE6NjP858Co4/rXONF1K8CFTRYJjwB44Kx3q9C7Pgi4hpRuRlqYOgQHZUYPZdm0+jCn3i1BATi5JoIpFJ6SLEAwbvJTyC3dsqWmPgxQAHmTXchJw9IcmAa3284OQhzD6BMzz5hMDsivGxkOmUzVxWYriKES3BD4tpBBoOlyOunwRUmxlm+QBZrKFETYG44eCcJKMxQoqSY40dAytbyzHT2jb9Dzd+fYBtRV6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKRGZsi2k1cd7aNbxObYP5FgZikVa7Jes1e4GL+YNhc=;
 b=UeT7I76/rU0mLHyEG0mFyfnQhFcRleC3nVd7dz/LMkPOipO1wcNfDUcZ+fqQEwl/lXrS6GNBofCrvx+qIBaemolIqlMjLUgDOle20vTe6H+HgJm+RJRfWCtH/vimn2lnsJ0WM52b6W/K5dzawyiJyS4t4psp6Y5vX1MD5rTogP8u1+dXKqbGRBn4ZWdmJrYZ5zAD1gDYUXCgUdaQyFdZUWAC8rVQTpYB+oFgg4jGQU3jLSw3JYiRcZN0j0FdbdFmJ0GRXE/g19aOfMyvu8JA65yGrBIpnIcCgZ9cUAu+je8cOMOenZ3YZAU9yYtBmopGCwxM+DBfQ3wCh5SHjC+SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 07:54:09 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e147:582c:8301:4b7f]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e147:582c:8301:4b7f%7]) with mapi id 15.20.3499.019; Thu, 29 Oct 2020
 07:54:09 +0000
Subject: Re: [PATCH v2 2/3] btrfs: file-item: remove the
 btrfs_find_ordered_sum() call in btrfs_lookup_bio_sums()
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-3-wqu@suse.com>
 <12990e1a-6e59-b0e3-5d26-34c80e31b601@suse.com>
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
Message-ID: <13937055-ab09-0a0f-b1e4-bfe7a710f5b1@suse.com>
Date:   Thu, 29 Oct 2020 15:53:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <12990e1a-6e59-b0e3-5d26-34c80e31b601@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:a03:1f4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 29 Oct 2020 07:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73efa2ca-7968-4407-fd20-08d87bdfd10e
X-MS-TrafficTypeDiagnostic: AM0PR04MB7153:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB71534F15638CCD6536986549D6140@AM0PR04MB7153.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MM9pjL0RP5DVt4YBPSkPV3p1TLCe6m8Z27d17vqGsi8DQ+ituJZZFILF11cYVluE4QJiXsq9JkPIoDWWhp9sr0Id4b4bVFMAZHSzXL0XMcsyCfr686UK3X5h7xmyK/bcyFebVKAsN/SQJ1RUwbuDi3b8T7WSqLK5+q/ukKobz1IpsEyRnpr8+TYJQ4kFqVs/07TZpKossQc//TJnDQywOwI8vRaVhBccP/4DKedFYI3g01V/M81bk1sr7Opp/4PLyZcJP6HnO5D32wndnhdD5gcMWFK1BqpDXZTeqSsfoKrtRPSbOEwO9mBTpXkPge/682rKv08zyIhES8lwyzqSgPZ2z0NAePYmWBnY08aTTh4/FzMpe6B4yx41ddQjX5BmmDQVL779yiZ/D9woilvzpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(2906002)(16526019)(36756003)(86362001)(31696002)(2616005)(186003)(6706004)(956004)(52116002)(66476007)(66556008)(66946007)(83380400001)(316002)(6666004)(16576012)(6486002)(31686004)(8676002)(5660300002)(26005)(4744005)(8936002)(478600001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hRodUSmT7lzs4pKaW2KSYSUFSWmhriK6GhCNU8TbpDTDV4Q/vh1hT9jVIXtVb92EQn2pNEA4I1Z25xH0Wqcz7wHbg98eP0rJA1Q6KBiTMRO8LW+7lbnn+q5BeGz443K0Zq2X+51P5jJh0Y9ZHGvZAQZRaURZCzO7DXvyvsBibbXzIxg+HG292qISOKQIlg0/FQT6gixoM3kresoPsk9XHnIrJmVn8omZKWeeC0OohQWHltyL3qXZ6oA/2REgSYen+dmN9wZBMiOWqilCQMUn4ER1q2+EtemwK2eeW2BSfHRFcfN+7o3cp0vsFmZZg5vjBUcFCCSO+fdk/JJhBRQEaS0UsMGzAOR7z//UKeCm00ZSE61ALAAgI/268cz1EtKuYgE2kOaYGWJ97rtMdFKHgB5yopM4Ll1WdDbMpTP8aYBYbKrkMmBnxKlOibxPb4g5J2pssDvdWEhxaO6Xh2ZYXCPQnjBlLSdjJ85Zyh5fKKgqoD3jxj4IoRykZh+K8MvCGMU2uJcRohOZHHgb4ggY4WRISZZDf+wtaiC9hAh/t19iimq/UeQxuQqQ6QaHJue7gyj09ThG8a7rTxksjMK5pZk+8EMLS+aNPpeKWGPzIRosFKLXrQmnS1df9kl6pWNjunip/9GRelQWGHPM+5JtMA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73efa2ca-7968-4407-fd20-08d87bdfd10e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 07:54:09.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esgXIAAtCFKGxbedQlkEFE2eyePGqC4a6dnVbQM7b7jnWgGIVJAveA2VvHQR70Wx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/29 =E4=B8=8B=E5=8D=883:47, Nikolay Borisov wrote:
>=20
>=20
> On 29.10.20 =D0=B3. 9:12 =D1=87., Qu Wenruo wrote:
>> The function btrfs_lookup_bio_sums() is only called for read bios.
>> While btrfs_find_ordered_sum() is to search ordered extent sums, which
>=20
>=20
> And what if we issue a read for a region which still has in-flight
> ordered sums?
>=20
Then how could the page tagged with WRITEBACK need we to do the read?

At buffered time, we have already dirtied the page, means if we do read,
we will get it from page cache directly, no need to trigger read.

Thanks,
Qu

