Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79742B7D0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgKRLxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 06:53:04 -0500
Received: from de-smtp-delivery-52.mimecast.com ([51.163.158.52]:43959 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgKRLxE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 06:53:04 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 06:53:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1605700380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=f3CBCoVnj8ixzFkdiMItZvzBmwqo0J4dS54C4aqi10k=;
        b=TMZfNgIOWCv6NGv2aGTX/1j5A632QfNn8+vsozj5BLZACqM3Sxo/pFBUNCTtvH+t4PNuj8
        8gKGhBIvhyR0uauUHB+qLL9WuuZauQsGirzljin0fcykvUITcxOPztJ5fkWxuvw2XVV0Ah
        lHW/M7b1/rUePUr0bsq8B4GvUQ5CueY=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-yAj5aTXeNPOK4dG6_V3ISQ-1; Wed, 18 Nov 2020 12:45:40 +0100
X-MC-Unique: yAj5aTXeNPOK4dG6_V3ISQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OduC/dueGe2PrJK2Q5q8zfaMD5XDOlZ6f1zKrEWnl/Vu9PzEG4pOvH3OLfW7yhGKZhLJ31Ib+rQX32MlwwD5aaxjwcpZRwb87x1rRbHkOeRYajrG+UtrCE6Lo7IM4H0fNi8XMuXGCdFi2TpByvpmFe6HZj4w8P/HLy15HdpD6X+enm7YGOVWhGCURRFdUX93SWA4BzdDLOvnaI9y3Ss3hPQkAI5vn8FZJcFWpDDnFsdmW0pkUnga834QlXZlhcDfmFMKWjvF4zpqtGr/eYX3E23+0ZQOWuKh/s/scSWdDdulyYMifKB26SvdmkP+NG0AmLuZO20eAIL+hxHgY4guHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qoi8QaYPE7l6N3pduiiLxmlHen9J3miEH3N38fddZnI=;
 b=iiSQr8bTra4KxeFB46CiSlysy0wYJbEr7pWWj5xDVpX50HfuNzUSk2Qo714wZB7QmNuVYQeVa4LanXKatYW21lFyvICDKeZYznN2FdpurdaslYtEmTVkWZISd0sRYLkZZnC612dzwWyJkiQKHPI9fVJskqYS60nX1onNJ2ALZebaZtjC/L5dscCj/l4za/a6sBKVO8LQej/MGrBdUBaMuPVRD1C55zXT8zvLnzKcDNN7nPlz2LgBr/Ff5g6FAJ3w7SuwW0Vnh3e5NI3Kqkg7ir8v3kib2GwKJF4enZXmYIOlfyhycYgmTTbLyc/asKb+IgwApJACtznfrOwPsCQxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 11:45:39 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 11:45:38 +0000
Subject: Re: [PATCH 03/14] btrfs: extent_io: introduce the skeleton of
 btrfs_subpage structure
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201118085319.56668-1-wqu@suse.com>
 <20201118085319.56668-4-wqu@suse.com>
 <DM5PR0401MB35912BB9DB2CC11CFFA7CBA39BE10@DM5PR0401MB3591.namprd04.prod.outlook.com>
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
Message-ID: <78423466-5797-f7c6-55d0-80a654363b1b@suse.com>
Date:   Wed, 18 Nov 2020 19:45:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <DM5PR0401MB35912BB9DB2CC11CFFA7CBA39BE10@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:74::33) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Wed, 18 Nov 2020 11:45:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ebc68a-d33c-4340-c5fc-08d88bb77855
X-MS-TrafficTypeDiagnostic: PR3PR04MB7291:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7291DBB64CE9C3CC2AFF9FE6D6E10@PR3PR04MB7291.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhxYBAKAPAaHmNydCmH0BhrxbRHdjF9vLeXkF2KrvRHciN3QHa1mMUEsauYwF6KQrXBfroWDtmNFANuDHp5KQ5KcSaMUSyB4btiwZhGieYRYMEbOrkOSU9/LqBstNKbiSWutbImvn+WRNI4V79EYD4KBfmfk8jzbt896dNDhxXAgn61QeQk72YbLIVPQpx65mHnorjXXhCIJcZAlfr5xNzrgCVnRvUeOBfUe4mkktYXFbzSb1/ejKvGcbFB1mdSoqbxH/YSlpho2DNfi3p1rMEct0uiaHETWloAW9bZ72HGCMkjQoT2iz6Y2RTX7geh2zvhjuak8EYVq7Y6hM0ctPbPxKlEFeY5jKmoTfOR9a6m48fXSo2ddckCcU4IrFsK5BJj0+bg9atZy6JbW8aT6Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(396003)(376002)(66946007)(66556008)(6666004)(66476007)(31696002)(31686004)(16576012)(2616005)(956004)(2906002)(316002)(8676002)(478600001)(110136005)(5660300002)(52116002)(6486002)(4744005)(8936002)(83380400001)(53546011)(36756003)(186003)(26005)(6706004)(86362001)(16526019)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: He0bfwGYskeIGVoKUwWkFzkTyVpJ3zOof2o2osnDk+gqtOnbyq8yynkibrKiQMcVEovmq9rPHavIbyPnTe7H3gzXjTo4FhZDqb6gh9Ncd7ucxea+uOVLENzmglYZtVDHXhXiwyLw61AHkXzhWNwcgWbzslUrAcuLO+c0qLWeU9+twTXeKyQOZbhLlHA9bM9LhOx2Yj6SlmiAr38pPsjzXmnFK/c77wnMg09KV1Ttu5kuTgZwveSIFnVUZ/7Jg4S5tj/dRwbtn7FbC476E0fU8IyheCl7jbSG0KGVWt+XYNl5NSXiAMiqKZSx83VbqukuyQ8YdxVrU0blsSOOTW1JLHJ5l7nlFlvot5e03m0gm11cxVbWP8wV/TEHzIrDT5Mm2i3Shu+CxJP2DCIxI+IxXAeBVuPOLKxlBRw9qsY/gJ0QdW38ZKo/iTXI31W9rO5xVRrDUmswa7rh8/Slz6ZALXy72AWZSIGvyNKPek5LZ499xbpWfrdkjA+/Cgt2V4KctXSxQMjJfOfe6kMKPV97KxWXz/X/x2fX0d66wrT2wVI+rCmz7oFSvzgPgRQE1v+l8CUq9Cx4R0wCokFHICtX63g90WuP55upNmXQ+chfK08RlrdntXzSYp4d68Y7U7pyzueydgzlbonqcDLmNSz+Okv4BpcCl+THvNVtnXXOiGxS9WQHX49Qx1Pw3rXOM+TZQUMm8W9DHTFb0RZ5UEZMKjePsOhA7ai0IqG+e3CQL046pEmFwLt8TriI8GOZuUwc14gtnhtmJMQQIrs47SJ5mf27IMT7NI2pLWmGCWMIws36YAbAB4ZBygdWpD/7oGs8ZDaBKHr8eHZNRH4PUOzNibMMI1nmBuWWLsLZ1XBHvnSJVNP/v0WHifXajbxTe58D7PLOmaAFZRx86SpHbITBNA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ebc68a-d33c-4340-c5fc-08d88bb77855
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 11:45:38.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DylypXW+rWlF+qqwbnXn4LIQEJ/6DwaZhlmLOxvyDgnWTCmaqRm3Z2ocCbKHTmVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/18 =E4=B8=8B=E5=8D=886:53, Johannes Thumshirn wrote:
> On 18/11/2020 09:55, Qu Wenruo wrote:
>> +	ASSERT(subpage && bitmap_empty(subpage->tree_block_bitmap,
>> +				       BTRFS_SUBPAGE_BITMAP_SIZE));
>=20
> Hmm from this patch it's not clear to me, what the bitmap is
> supposed to do. Maybe add this ASSERT() to the patch manipulating the bit=
map.
>=20
Indeed, this skeleton patch should not utilize any bit yet.

The tree_block_bitmap is mostly utilize by later patches, to indicate in
which range of the page that we have a tree block.

Indeed I need to improve the patch separation here.

Thanks for exposing the problem here,
Qu

