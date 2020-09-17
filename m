Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507F626CFD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 02:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIQALF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 20:11:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:21887 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgIQALE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 20:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600301460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=HBDcVcRS9W/SkjDko14MkPywMaFXJtygbpWO5UzUpPE=;
        b=RHqHX1tp83Vuc89PA5yZrWmXDBPe/8j/W1vz7BUn7Jg0TPdFlG5bVQC/e4KUEPx+svcLyk
        Ti1lhjhJCpaHrLIfpv7HXvY8uf0kj8yal/u8P5+BdszXxTZmvnLHXUkZpIj/14wUaTMeJ3
        9jBrQlrBogoqPs7aPA4BjZ3LKizS/ik=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-5t3Y2itKN5-zYm9Lrgcimg-1; Thu, 17 Sep 2020 02:03:44 +0200
X-MC-Unique: 5t3Y2itKN5-zYm9Lrgcimg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9NmYWoT6J7DEBUElBFE/0s9YRfCPuI1OX21GvWT7DmlqqXAlJRaHrsIdKiakp2h18tcBOFXzLay7PCW8SJDn97BREjwJpgtcEOBnMwqLAvtr3Rgy8V4aTL/SMBRNzexHgrcnauqgwfrsvxv4TghiHLmDJ9FCxbx5mk+rF9ypTNZTO8dyiI/QYTsJoOcp6MQvOyA3jDLZ+BDRupm55mfC4Bj6yMpsUXtOtD5sKjH8mRpVnEGnmYxehbopk6XPJSO1wmCaJedmP2DVOMW9aQxIHe4iFrOnSqAHdsPsHTnZy4UieBLIQF93y931wC8TGzkUY1M+lwCslTF8ibeY6a0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljGIqORZOKvZP/qmD1yXq9BvKftYA3G9L48I1NX00o8=;
 b=lFkqWOBE1V/+eBdwqkjQR/3DqJAO9RUVKlp7mInhZvYVR5PeqktU6SjqWhYLl403aLGhKxQMT7aTPZCB+50W7tBi2fQ5lcsHvWat+dqmBu4CC0Qt1wEb7s/yiMM7WTBy8PIw+1P0Wa135sEekcaX01dSRbMVnxoumoyANab5tW3a6RyOf+ukBcfF39Vn1oZKghiCC53l/jrupCgs+amRWD5zPWOlz3BJgmQSxc+P+dkU2XwRjZZI7fMw6HFdQF8EMTAPfbanu/ur76BCeyAfj/w4fZotmOxAjbc64RKUrvT+3mD7atrYgxnC2RBDM8i4HOhhaCjnsEETgshIduI42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6193.eurprd04.prod.outlook.com (2603:10a6:208:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 00:03:43 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 00:03:43 +0000
Subject: Re: [PATCH v2 00/19] btrfs: add read-only support for subpage sector
 size
To:     Neal Gompa <ngompa13@gmail.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <CAEg-Je-y6BaXYbfDOdoeF_H85E2+PqRQ-PCJrW6KPHe9Haz6MA@mail.gmail.com>
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
Message-ID: <6802c45f-16eb-90a3-4ad5-b3bb92dc4cbd@suse.com>
Date:   Thu, 17 Sep 2020 08:03:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CAEg-Je-y6BaXYbfDOdoeF_H85E2+PqRQ-PCJrW6KPHe9Haz6MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 00:03:41 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4fae644-3292-411f-bac4-08d85a9d2434
X-MS-TrafficTypeDiagnostic: AM0PR04MB6193:
X-Microsoft-Antispam-PRVS: <AM0PR04MB61930A212566E6A9B98D5586D63E0@AM0PR04MB6193.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KESvivg4m8HUGLbS6CyU1g4HJ7bkaL3a017M7MguCt62vmBrNiU4wscwYX2NWXcQqVCMRMv/r9XYNk3HhXCDUmeeITD3QCM2mggLFIWgVBjmOP2APQcYPszvAUtwGOThYH3I9viSWFKHRUaBChUvTOZpe3wTTVaSFIqe1oHVy+ya/fIVz5CXuW4TW4KyTi/6f+UW6xIcpiVIW3SOzCK/eOK2Q3BuCGX5uKz4avR70NlynyEbhu+Ckh73B29tvWEMV0Ofw3NR16RB6249C0wWvbx/N5zrK6n1M45bBSAogw3gQE7UpumdcWscBbZg7e070lJLQ8fjC9LY8CoUqV6rbYCHoZcQF4n9mn+bDL0duR/Wj93w6dKY72YRAwqmbcIcd0U3mMZAn8I6hP7oq+uHgATl1GDiA+/9BrB+2FrbSpelmH0TPQO+fuGGklhVDHwKU2/NFDZSy3+UxTbPV1PpNY8f+IdLLzZQeTr5XwwAng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(6706004)(2616005)(956004)(6666004)(478600001)(16526019)(83380400001)(26005)(16576012)(966005)(8936002)(31686004)(54906003)(6486002)(4326008)(316002)(31696002)(5660300002)(52116002)(86362001)(66946007)(186003)(66556008)(6916009)(36756003)(66476007)(2906002)(53546011)(8676002)(4744005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q06EdlvCsmCzIcawLOryQBKgWq85E86jFB6SrwYbbBD7PGqx7HlzLiujBku5SzhYtXxuIHsoI/ATT4n+sQANT2ybj9aZB38Yt4BtWau48ImekawJSMzNJIZ0frLCIY2BT3uVUK2VrzPgFi1htz7IrY/QWUryu1KygC70BdwLGG8xYbp6MvnHBeLQjVppDrZAAf+qOGtTpzMzxxUirH0cZ4OkdjHOQQ5uPb8l65hG2/N0Cp9heJoPgiieOr38SMOr2QsTnavBfR6d4/shKLWcDdxacS1I1mGham3qYPGGq9IrD/v3zdJUKkt7yA1AQPlYzedn8jT7zcv4zoFbX903Mno34a/LAbOs9jv5tw4eVH/fy696m1ZGdrNoVoYDB57BT2DRIMke4qGdlbSZvf51QWE08eJF4LdMmh+tkjtxZKq1Bo/VL9vKQSHTlQuV7lkeAX6FGBGvo03q6/8rLHGJMW+fJEcZ2FK5oDJ2aApr94h9KWenWmClkDUBd7TOPvFG1j10a1V4x76jrWhy3czgAGJ2bjKuNtaXJF27vP73hIKnbyV3ukfl3aj7moEYCJg5jl+9MOYF5ISdgxMvISo2vIkFcJsiJ6Z19MD+bs/A3MVLSKGjAsIW9hYRdKYKpgO8fy6ojD2YRNImY4hyonLuSA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fae644-3292-411f-bac4-08d85a9d2434
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 00:03:43.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WADNqiqCXhiU2sGrZ5PjT6QJ7iY+zlxRPViRIdVBqlblx5rPQFsG6qSwaTEpGoo4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6193
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/17 =E4=B8=8A=E5=8D=8812:18, Neal Gompa wrote:
> On Tue, Sep 15, 2020 at 1:36 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Patches can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> Currently btrfs only allows to mount fs with sectorsize =3D=3D PAGE_SIZE=
.
>>
>> That means, for 64K page size system, they can only use 64K sector size
>> fs.
>> This brings a big compatible problem for btrfs.
>>
>> This patch is going to slightly solve the problem by, allowing 64K
>> system to mount 4K sectorsize fs in read-only mode.
>>
>> The main objective here, is to remove the blockage in the code base, and
>> pave the road to full RW mount support.
>>
>=20
> Is there a reason we don't include a patch in here to just hardwire
> the block size to 4K going forward?
>=20

Did you mean to make 4K sector size the hard requirement?

That would make existing 64K sector size fs unable to be mounted then.

Thanks,
Qu

