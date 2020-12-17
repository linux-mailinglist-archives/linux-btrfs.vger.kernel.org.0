Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7472DCC69
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 07:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgLQGRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 01:17:12 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:22597 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgLQGRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 01:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1608185760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FpGPf7a6Q/TfKB51PHrkHRL0e8micLiM4r0jPO89Nc=;
        b=Nf6hYzZSVIwvtKYkICm7xUfcgqJKi/txFLQcMok9v3JidT3ACDzNf7z8f+P0s8i7NUQpzp
        KHSLHq/xmqwtku8nc0Odvgbc0ozmJEWTQrks1w2+0/5ZutzYVz39yH705nDYMNbaOrfNVz
        aIlM6lw8Szwv+f0TyHjbJ8qxD76S8E4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-7-iEep7yt9N7OVVtEV-FGPBw-2;
 Thu, 17 Dec 2020 07:13:50 +0100
X-MC-Unique: iEep7yt9N7OVVtEV-FGPBw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTxqph9ipcjyhLxxkGdFXnwbJoIUR8Wgh4NXFQivGKfblZ2biJ/EJj6NUplkeuqpPQH6cWzN+bi4YaEwdOj/vhMxmnD0oZme8hdVpI8C6Q98OUVnGlF1C6LudIGhJSHFPs+Il4MZf5IkUaEFBImloS1fzpWH0YRJeZcdri6hIJ/2T3yqOYUPesPoLEcbLHTFtpZmW2aAUlu2w2YRoMkUqbix63aoHXx2tUdT3Vn517pxsX0ydpUgScOaZUv0VWnCktHPjtv4KJqDFWanqYJCe0qDe6ioiEEZA2bBZkW+FYWimjaDQEuD+lyuijsJhEvZDQvK2lmEGQ3KAE/Cfs1/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9wU+BKEMSLpJPaLXy3fjUvp2G4d/m9Qzd4uKsL9fA4=;
 b=KoMO/4ufgsFbBRhHe+4V1g9XBxInWfcJ4FYzKs9S4/Lx6B8kvszoHw91lCSEoNrgxa9/8ibhX/R6PMrbY/Hf66r3L0+XNUmwRayN/Xy1bLOUuFGP6gX6gDdJjqPAqAxxJWM+2jfB4Pcb6+EKyjGkBvRs76SbUWTx9qAjqGck8JOqOMjbCdSt+Rf+YNiZdLbLvDV97AzmzGZfzEgf9Y4MNKodLNxkLLr1AZMuah0EmzulYbXQHMbtQOXDVMGvU/LMEeq6l6jWzu2N/XB96TbodHNOnPagj8oDGbDZoDTtUb83uInR6W380aO4b2VC4HnROAamZGtjjWEr7XRyMz4ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB8015.eurprd04.prod.outlook.com (2603:10a6:102:c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Thu, 17 Dec
 2020 06:13:47 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::7d12:a0d8:a763:82c9]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::7d12:a0d8:a763:82c9%7]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 06:13:47 +0000
Subject: Re: [PATCH 2/4] btrfs: inode: remove variable shadowing in
 btrfs_invalidatepage()
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-3-wqu@suse.com>
 <cdc92e68-90be-d88e-85d7-5e7191d35cd0@suse.com>
 <b7c83de9-24e5-3702-96b3-467363ada642@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <b89449d9-9918-8f0f-2739-eae2fad7fe58@suse.com>
Date:   Thu, 17 Dec 2020 14:13:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <b7c83de9-24e5-3702-96b3-467363ada642@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:c0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Thu, 17 Dec 2020 06:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baa15780-e1a0-43b4-8d86-08d8a252ea6d
X-MS-TrafficTypeDiagnostic: PA4PR04MB8015:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR04MB8015604D1E1266CF7FA7EDD3D6C40@PA4PR04MB8015.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUjBfMgqFKaA6cCkfMKVTjgnQLgKEHtwf5jQJimVWiek+H+TEqaQMpjBAYQ2kKNzJE0hXid0S9oI8Shz6+feO2Xx977e9c8OmE+erUNwD0DxL0D3GOrRj3z0iZiLxdaQs0nZ8BwkPMi5kkojT4zF8mOWEkK9iI0ALC6FV3fCMlMW8yx65RP55ItP3AGLKzou0iw+Ipt23r9eJLoQC/e6IrtvH/owKCaxdJkN7B8PIRwZ/+LQZnhoquZESQwWC5Q2Reu7V0Mf4bceVzde2/UvbZsVXFNiOROlKtiHO12kE85z7mklVratOPvgtmmOW7fCzXeJFkE5PshGcfz96ON3TnqCkkWcbw8TfKSfRtfK+mhZWztORWn+Z45iaoMv34n1wocbfnXYXmIilt8Y4YN9whqJ8ftaVKiSPdgtdp+u6XaACwAQCsYKpGmurBGUvuhb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39850400004)(396003)(366004)(346002)(2906002)(478600001)(31696002)(83380400001)(52116002)(186003)(16526019)(36756003)(956004)(4744005)(6666004)(6486002)(26005)(31686004)(66556008)(16576012)(316002)(2616005)(86362001)(66946007)(6706004)(8676002)(5660300002)(66476007)(8936002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OsKc/zEnZsCNn0UTkNBK3oPBQrrml12BU0Q6f9LNFTgu7llbfTrOOtmWeY8s?=
 =?us-ascii?Q?GQdzmD2PP8WWFX1tkx7nSEWD7g47QJzx7Gf+s8WmRz53L4Knqpp6DUgMBN9V?=
 =?us-ascii?Q?fX0T1LfL3pSIgWtlu89c2GG/ajxM/ordfkAXKR65pVOfkXWkveYxFkReG/XZ?=
 =?us-ascii?Q?w149hMmz3gFQJPnYxv5ytBGColhLaJ3eGyLe/2OB1P86h+hsTMy+KAojeO3J?=
 =?us-ascii?Q?npuhmpHsnrR+K9bfRaap3VMEGNnnCy/UVPAiggjRvvScdU+x+A2iCitjkeaR?=
 =?us-ascii?Q?7NUg9pbrCtHF6xeNLB5o5X49diC3+pJZZvDQI4dVDQKTloDY8DMLD68uMTMY?=
 =?us-ascii?Q?msqgh7AiZzAbow5z1eVXMD/i9cMx7LGH9iI4EEaCDFThnBsKK3YhfqWhTL0A?=
 =?us-ascii?Q?6tvXTCRXuNSSV92wgmz+MCjID3hBcfAzUl5XjdsXgrHU9u5BPEZGwAhaW5RE?=
 =?us-ascii?Q?ZZhYbLl0th9XB+4Wjb/lNpoT3fFgUOxImjFEpiqVjztiF4VcpepuoeenffaS?=
 =?us-ascii?Q?ZPULQdEdQw/kN7i2zxcrgs9/GCPn86F5TKKinoKEq6lfGh8/oY8zxBB0+h9Z?=
 =?us-ascii?Q?QZHPX3CHJzJgsszjaqliW2Uq7/4PE/njf5DxNTIYapJ1w2U+etDCSUWJmwo2?=
 =?us-ascii?Q?q4maTAMOvBQo6EGd4tzzst3v1a5eNTtAKDOTNmhHVt75l8anUljqEYJeHMnn?=
 =?us-ascii?Q?i1TldzLpriWWBgWDVFqInj0tnpZv3Z6mOjuXnioTXUspiL4QVWZPSLN0jwe7?=
 =?us-ascii?Q?S269ikBOB3BG56Xz0gEqrAzX290aH7vR5BkzmWKHkGraB8PIV2/LdKucARTQ?=
 =?us-ascii?Q?vNugaD9HKoA11BrqaJjCSfEw90ej2DfDyJIWOiCXAajH8H84R+H8QAhejtEP?=
 =?us-ascii?Q?z/biD8PdZJWmkHt5/SP3a47YWeWquwY8QcrwIU7BTYcYe4+KpUi1gYSnS6Pt?=
 =?us-ascii?Q?29UsEQGeuEmxK7TNYflgWOFH5GSRDRJPivbNYkTFve9rEsWjb5XudmpZdswM?=
 =?us-ascii?Q?DmfX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 06:13:47.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: baa15780-e1a0-43b4-8d86-08d8a252ea6d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/D3AJLubawam50wgDEarpdka26bZ2Zq5VBBK8VeQAjbnRv41jQC2FpdwaFkSpoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8015
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/17 =E4=B8=8B=E5=8D=881:59, Nikolay Borisov wrote:
>=20
>=20
> On 17.12.20 =D0=B3. 7:55 =D1=87., Nikolay Borisov wrote:
>>
>>
>> On 17.12.20 =D0=B3. 6:57 =D1=87., Qu Wenruo wrote:
>>> In btrfs_invalidatepage() we re-declare @tree variable as
>>> btrfs_ordered_inode_tree.
>>>
>>> Remove such variable shadowing which can be very confusing.
>>
>> You can't do that, because lock_extent_bits expects extent_io_tree !
>>
>=20
> Ok, nvm, you just factored the var at the beginning of the functions.
> OTOH since the ordered tree is used just for lock/unlock why not do
> spin_(un)lock(&inode->ordered_tree->lock);
>=20
Oh, that indeed looks better and since Su is also complaining about the=20
declaration at the beginning of the function, I guess that's the better=20
way to go.

Thanks,
Qu

