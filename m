Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691462D85E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 11:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407211AbgLLKc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 05:32:29 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:59598 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404988AbgLLKc3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 05:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607769080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YbD9IMBdBN0RGeFzdtfQtNFI3u4dJ53k810aUB5Q1k=;
        b=Rtvcj63BoX6vjWsxkvcu7gQRwvFIQffjyfEZIUJ+u60FJs9x1bNQdsOf2kPW8d5d99pNms
        yNXAGLYdLwRzEC6eODZhhlwl8MnfWb+/A3fF7KBO9AnwXJ9kQpvtaRM5Z8OL5oAy0xmpJy
        MVm86U03YqYupH6jvOIihiKjFvpM6LA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-n44dRsnDOPqtEAdfVAocsQ-1; Sat, 12 Dec 2020 11:31:19 +0100
X-MC-Unique: n44dRsnDOPqtEAdfVAocsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3zLZniFZdp2rzMDKlc+ErFF77c90Jdv+9E3SY2VJaK/BdZcx2wueUHJNQsYqaK4T3I4z+1ythVm3YBBfnARm03ISrWWR2SbNV8hBWDq7E4BLhecDydJ25ycHNiRvqltFlWCOyb7yxLHSsGZ+DfEYRBHxhSjiII21ONt+/dIRuVhpjnMCTdcp8m4oqOADdEVfiJ5zkZcozN/0DODd/ZDNSOVjniVlpUQEBsRMOWtPIeK4uV8vuwFY980Pq7MqI1KkNhy2UBXRg3+3qOJJaRrg6zklYaXHx7h/0GCA1/rY6XIq1pAxlV5L+fJ1/6UsCjWJN11sI74B/BPzNsIzW9CiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGF2VmW0+r2ywgqI8ZA+K3aMIpk55ncUg7eu0skHoZw=;
 b=ZUP15kq4ZZ0JEICO6jeqnW9NNzxwsx5pDkIW2ZInYuae4r9i8M+duscfcNK58iSBAEPiTKx4TZQuqf4d2LshWGZ0r90s9hxJ/zXcGCQ/FypGj5+pGdtSzFyjwlLA1GHfgI+I2Bv/2fEyyZ+nmAm6NVwfdBj04Y3+9GV4BCStnidmplnbMHJHrbSKuRSBJJl+esBUGb3GvtMyJB01ByK/u+HDttnKZMgZWCc721U1e3Z1olzw62Tihqkn1dKGT7Z1gtgGrVEdL1slmzvzvUKLwUmd4SxqgC1RNemm+veP///tfobFV2IN8pU2xAvrJkwmdBin/D0MQanCU0YL1DrKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 10:31:17 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::7d12:a0d8:a763:82c9]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::7d12:a0d8:a763:82c9%7]) with mapi id 15.20.3654.013; Sat, 12 Dec 2020
 10:31:16 +0000
Subject: Re: [PATCH v2 12/18] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-13-wqu@suse.com>
 <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
 <a2732cae-4dea-744e-2eda-8b8e5f2b6710@suse.com>
 <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
 <dabe26b4-1ab9-04b7-26ed-ac7f186e5d3b@gmx.com>
 <b0b6434e-853c-2540-dc76-eb40f8e70885@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <68f5abf8-ca56-75bc-609e-9d58bd42abf1@suse.com>
Date:   Sat, 12 Dec 2020 18:31:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <b0b6434e-853c-2540-dc76-eb40f8e70885@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR16CA0027.namprd16.prod.outlook.com (2603:10b6:a03:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Sat, 12 Dec 2020 10:31:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe3284a-ca3c-481d-5414-08d89e890edc
X-MS-TrafficTypeDiagnostic: PR3PR04MB7353:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB735341F4429F99DFDE822F5BD6C90@PR3PR04MB7353.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjyBKRu4LTbDcMI2BVU+Im4N4i5189T0Ui3zz/L7bG2NTZ4vmSbb+F2c/CMfU8R4BHfxZjhvqIe/7oJnwdiSC1lgPt1RVDRCg87CGe1djwZcv+XPVmMlj2W3Wb+qaH5drqelIR6R+cfAjp2QQrU7zmKIa/vo3Wa/gVDUNounlGHtYYxIqzFYL4F6YcJWTj/4kwAx5xn+1TWLSmCY+1waId9afyubivPekk7RVxbPTH/sk8/6rdkZpYDmBIyDDM341v3LE1wQSWB84JtUo+5NlABtr2V7a49E8boWbZ6dcVZT6Qr5YI0v7McK7T+ljflU9Degw3cG0pe0HKcwHLLQQTMgeGLzVXS/sooOp/y/KjZax7+U7/SWu4Zk3eojkRiOG7N38xlRuWjhR+ab6zoG7PCg0ImXJaKZdr9KDwUVUP4yj0hqmvjsm98xkU6XvNFK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(396003)(136003)(66476007)(66556008)(66946007)(478600001)(8676002)(8936002)(31686004)(16526019)(186003)(6666004)(86362001)(31696002)(26005)(110136005)(16576012)(316002)(6486002)(2906002)(956004)(6706004)(2616005)(36756003)(83380400001)(52116002)(5660300002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z/P2MJionqMLPvjF9SLBFEHCML8rkh6r1zmSXmUfc7X1r1EJBbZc933Ak/GW?=
 =?us-ascii?Q?Qag7yp+3i+6NR/pP0kET1L19m1+4kjhu3DR3APDiLA1Lnf3cnIJKBgbSNapC?=
 =?us-ascii?Q?ITMW1pgtYpKBjz9sdgatn7oXDoYUWD0bFUlyHSyN+0Iahdf7yGVPvcWPZ1JG?=
 =?us-ascii?Q?Eey9qli4MlnDMceBUetP2ERc0BfRYi6/z30VFZaJWcbrGfAEaei+JZ5yGu7x?=
 =?us-ascii?Q?PDUa+6NVKrM8Hcwr0sACCbXXsnCRLHEGA7Ys866pxibqYFrZyMEOCMAOl1Dq?=
 =?us-ascii?Q?PEBo1G8gQiZaM5O67sExor3YrI5qNbo42TZpVAc4XaPmXUbRFAv8TvzDs6pC?=
 =?us-ascii?Q?U/LotEVs3e4ZlQ/9JF99jTQnqGdnlSkSmgjzHAEiWfycMZ6W/D87urbiy2yc?=
 =?us-ascii?Q?DBJV6MN9arqAvTzbvjVjdweCviyFKxXTTwxgVXk8Vx/HrtNa9jAQWnDAXDOj?=
 =?us-ascii?Q?tuHoQr7L9qyDqpbmDYOkUYIl2iI7E2cFcMd4RVSeZf2r/fdfK6tr8DBo4Qkb?=
 =?us-ascii?Q?oV85sZdSeJ+s7mny0+No4l4A4lFskZL1Xqmbc7ysIxxG1H2XQt0R8tFUPQMF?=
 =?us-ascii?Q?ye45qgASWjWJmZn+cGJgHnORQDivyObw6yLWfRBh5PVOkjnxN/PhshcJNhHC?=
 =?us-ascii?Q?0bKcodGVhW0uFZ1HYMjh5kaE5gBm6nDMxDRSxfe2mf1v0BUtgXOh2t2YgoaQ?=
 =?us-ascii?Q?o7yO/hP0IYvkiUDttY3YZvpUV/lj7v/yVhuIpFOtRLG2a0dPCs2Epv5uyIUz?=
 =?us-ascii?Q?lXnJ93oceRNF6UF6XpemibBmcG4MIr0kRONj+343Ua9m2233Hctc1AFHgmVh?=
 =?us-ascii?Q?qx10jXwIBO5d5z4bvDFPDGawGtijnV5Ne97PZJLFtZNvpvRdlvCq399cIr/+?=
 =?us-ascii?Q?90EUyzXM7elLX9sCBgFZg6aqXuM9hCExi43+mUXubtwa1YSsJ1fqmemYL/h2?=
 =?us-ascii?Q?MAWiJeQVLkvn3iaBle//i29ms+atSrLtyokoWCTI2taFpVToaOZO/MzQiFdF?=
 =?us-ascii?Q?OKns?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 10:31:16.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3284a-ca3c-481d-5414-08d89e890edc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf+mUYKwnY4nNmOrNH+VrpQsFfwi+Yg2Sz3EvvGPtFhDN5GJsTEFNbRlYUR8sFnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/12 =E4=B8=8B=E5=8D=886:30, Nikolay Borisov wrote:
>=20
>=20
> On 12.12.20 =D0=B3. 7:44 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/12/12 =E4=B8=8A=E5=8D=8812:57, Nikolay Borisov wrote:
>>>
>>>
>>> On 11.12.20 =D0=B3. 14:11 =D1=87., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/12/11 =E4=B8=8B=E5=8D=888:00, Nikolay Borisov wrote:
>>>>>
>>>>>
>=20
> <snip>
>=20
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we can't ca=
ll find_extent_buffer() which will
>>>>>> increase
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * eb->refs.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb =3D radix_tree_lookup=
(&fs_info->buffer_radix,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 start >> fs_info->sectorsize_bits);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>>>
>>> Your usage of radix_tree_lookup + rcu lock is wrong. rcu guarantees tha=
t
>>> an EB you get won't be freed while the rcu section is active, however
>>> you get a reference to the EB and you do not increment the ref count
>>> WHILE holding the RCU critical section, consult find_extent_buffer
>>> what's the correct usage pattern.
>>
>> Nope, you just fall into the trap what I fell before.
>>
>> Here if the eb has no other referencer, its refs is just 1 (because it's
>> still in the tree).
>>
>> If you go increase the refs, the eb becomes referenced again and
>> release_extent_buffer() won't free it at all.
>>
>> Causing no eb to be freed whatever.
>=20
> After the rcu_read_unlock you hold a reference to eb, without having
> incremented the eb's refs, without having locked eb's refs_lock.

Haven't you checked the original try_release_extent_buffer()?

  At this
> point nothing prevents the eb from disappearing from underneath you. The
> correct way would be to increment the eb's ref and check if ref is > 2
> (1 for the buffer radix tree, 1 for you), then you acquire the refs_lock
> and drop your current ref leaving it to 1 and call release_extent_buffer.
>=20
>=20

