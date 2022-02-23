Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA684C1108
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 12:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiBWLKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiBWLKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 06:10:54 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFE8EB69
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645614625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptUg6da/f54p0geErLdrbGHpBCCTq7mZqZJbjKshMk0=;
        b=fYLWyYeUcTPgU7zIIt4BzO4nPEVIvQqImxC5+ofmqbBhjCJsDLYBffZEl1sAcsuM+EW2V0
        DMNFUAWQ0m3KdzBY3VXIxKwRPX+giAqk0I8HDbp8wp0kyPTjHAPpQIEDrA9ce0Fhtte3sh
        qBX4kiYhOEBSXzU64gV9miUPE41zzdY=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-8XVQhkfIOOGoDzOcy3oICg-1; Wed, 23 Feb 2022 12:10:24 +0100
X-MC-Unique: 8XVQhkfIOOGoDzOcy3oICg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajzKVDZQhrRuMQI+Z74hx31uwuUfESENUcvi54gftxora3HpyQSBghwoTm+OeYJteOMj/mxZXq6GS/I4fCGz02ijbh9cGB+zYuFnrpqnQchHIZWjMmKqIiQlQ0mNSO0AjVrmhgR79bP9dG19fFKt6oBE/sUPtPeLQn3KJfMc1CA2CaT/3paqKOVIgSINDlS2dRlvLEflINng2bNtq9cpRc5sLjk3721vxmvIb4eN/t32vqrcc/TuPJq5GLTiZ41pHPLObu9zVPoQ+R+jzcEPgsx6ruxEGQ88GYxElYraMKNj/5yvPxeT2EwSba8utnKsPNnUwcbMeCsxRjb8iOJF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/ac3YWge3HHxiFSAZOXx8tcN++m6he9sFqJlbNFxW8=;
 b=caPnLGqwmuPmGelaUzeNuJ1TEP4tkZNCX5gC3Y0GKrP50tlv+hmHXXd1YDsGUNKWoJ0v1OzvC5aBf2LuRqbZtdqn2nfQHSwmW88npJNXrQSfHVUhbi2WIGDcv+FnAYOA6jwu937ybvuibXEkXV7XH3bXsne00H/q3Wt9RD+U7NjUyeAA7vhCGAfFsHFrwnehNUJjJH5zO7cLyybpD764cZ+r3CpoHBmNmKlcytN5PJyyKYNfxTYoWQUnDUxHQXn6mVhq+CeD3JpRsopYnOWDoq8wf843dHsXTC8zfzDosMF7kGlHnSygoXBoxFe8lAZl4kiNhrdtFxMjUF393uL72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR0402MB2863.eurprd04.prod.outlook.com (2603:10a6:800:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 11:10:22 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:10:22 +0000
Message-ID: <3c25d70c-43fe-cf38-33f8-05e35ceb03f0@suse.com>
Date:   Wed, 23 Feb 2022 19:10:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
 <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83bacf3a-6373-4d62-2022-08d9f6bd15b4
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2863:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2863F9D7D0A3666662841469D63C9@VI1PR0402MB2863.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18JQ89+Fc2cTrpOgBNZfi1H6masgLZnWydW287WpO1A78GDcSFju2E3W4SzZmSESrCnjoe/gkp6t8VaBlWojVN+0ldVCyqwAhAK0hbBdrSb1fkAYzRnQNwaOUT2iF+rPdwZwTsEK2l/sSDfxEWkoAWpPZbnT76HVi/FiDjH+cmL8k8P0OsVPU/5hdZsy5qiWxc1K1DQWayvUlOsqH9tUB54t5VP6sy5YUOzVn9V2J2u0ikAt1zfi3pYiZtpyv4bn3I5TC5slqFAvNBibDl87sNv0NzELfLajbtL2rzUmwBBv/NUJEHwkJFWbOiG9uLreVcPp82/Eb2GfrmrD7wAgsMzk7LXfzP/eWcIOQe1HSol0iiIJbojqovmYkiGp+49EOwuu50WZ7eVZAdTl92UPgYZfhYx7GqjPTi6Dz6YnbaRexWLVeWfTUzLSoWYVom0nz/qmB0jf2g7za8GN98X4yrg6atcwM52IV0ffSyvE0aUXw7fzqFOB+jVA8/DFpyoQ0o8Ujd8INANbjp1tm2wGX5HBKGWBAp/oD1bI22btsH4wBuzp2dTdEXcWBNk2mZDlQ31Yh1dRa8s8+H7UF7HzSPEsFsc7two8/0OwoUTEGDVZ3zLPNwYMDEeGmvU81gCmC0VibwBawGwjIuBjUlsZKtrAZLKnTZ5YGzOEJaaC6ulBlC2v0AFTw4A9ec2OIWthqAgve0y9vhH7wVwFPTloKu8SK93ibq96heC08QEnzuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(508600001)(31686004)(8676002)(66476007)(66556008)(66946007)(6512007)(83380400001)(2616005)(2906002)(186003)(26005)(36756003)(38100700002)(31696002)(86362001)(110136005)(6486002)(966005)(5660300002)(316002)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqhV3tAowntoEBYJIsfBf3bg2pXlex2WL970GOy9KtQ0Ckgr0gi63Qm+7ttH?=
 =?us-ascii?Q?HDDjbhoM7MLDU6H4/n663ialr7pzMw0ceDRmTCSliRDK9+dU+Z3YqdljPmTB?=
 =?us-ascii?Q?cYM8e9JaVyuMKQehHMrbn3aDRGa+iWJbMpFk3hcnV3fZ4aGGuMLiaCd/aUpx?=
 =?us-ascii?Q?8wUPsb1eHaaDKMNvUP1Hycc54/YccUMc/4zQ97B0E73JUGF7NOgGOmlST0P/?=
 =?us-ascii?Q?trftVKvO50J9suCCIDp9n1JWSVisetD15zW7w1R/JJ7QbaPmcMAi6hbn7viJ?=
 =?us-ascii?Q?HWlMfUPh6qL0jBDOCI2Tt4p4fYtnrhzIolAXktCo89eHOJhIfb0U9EXIbtMn?=
 =?us-ascii?Q?zTeDPnCubD9EZ57wBwkAMpRNzMf744rMO5FKaWuso7elhXUgjzvPgS4XbL+6?=
 =?us-ascii?Q?NR1Lg4rSQJXiTbVyI+k/s+dfDkuTnPv4C23/W+n5uA9B9Bez+jyj1CzRYNaP?=
 =?us-ascii?Q?FfSF+HOyHDR9CL2YZs3gqV2gRY8QiWKwiH9cjXx8We4Q4mTCJyaYTPYQUIb6?=
 =?us-ascii?Q?ZXE0Tl+KepkQpMOvzcm2/DLidokAigX4euLJwAIuITyMmmbZg35JHhZtvNyS?=
 =?us-ascii?Q?jZm3NLQoWcf2v0v7u36/vmxd9kzp6nbAf/Ap4ohqPaFPOJjKwDL7eJkHdtQE?=
 =?us-ascii?Q?0D+cF8VugncZJud/A8Olc8WO6bnAnC5sWeH8DKN/PA5NLmHZjmwUeHXbpQV1?=
 =?us-ascii?Q?5mK/AWvWX1arWau8jrZss/5RlKvvnQa8+ARetRDN5A+bgG+T1ksSkrTAsy4Y?=
 =?us-ascii?Q?NxLO/xO4xPfqS7iSD4UXaLLtz7WyiimGTpMB4SEkTWqCuZyt8N2s97cDZZ/L?=
 =?us-ascii?Q?2z0ekDnyTFsIjoHaUVMpaQSxE6fKyWnvSPklVqZAgXKLGZ9RfQolxocnGAd/?=
 =?us-ascii?Q?1CInbiBAjk90MNUItKZyxkPkeIweSdvxxcC9XBI4n5aqSTmNAMByfksmVRXY?=
 =?us-ascii?Q?VPS2vNO2hICXCBhI9LOXtzH+r7SjTiano7c/042LFeWP/LCuo0sXqnm0QA1z?=
 =?us-ascii?Q?liUeabZTxh616GNFImAJ3WQsk/qfqvIPnkggZ4zXPveKa+raimhpvnGJwVYf?=
 =?us-ascii?Q?6NdGoVk9qytguskFofA9l0JpddW6uOB4ZWhYpb7H4qQUeuFc1AKC5H8yOBw7?=
 =?us-ascii?Q?LcvwU3nRgsAc9mnRpfg03/M/02zhR2VGsSTNmOPip5nX2Mu2FVY6fGrz68N2?=
 =?us-ascii?Q?B/ygH8mhQLI7bML4wbeOnmopcKhaFteJ7tdFGvT84+5O4e7mm0nCbfBu0aeq?=
 =?us-ascii?Q?tRIw3pVyrCfDrHxVe/9bxwp1pZgYGN6KZ8CTnyPqptUbIlwTpkai/QXIFxrP?=
 =?us-ascii?Q?RO/fHCa04V+caFxtkQ2j4Lj6QpCpGDvrgQ9jxCCJy0KYD5CC4mOy+NAkKlHF?=
 =?us-ascii?Q?+RUaYyt5IJjn0bNCEL2ISPXGiB7omS/iWXZHnKEPxW2DVDuruWTtMa1aj73l?=
 =?us-ascii?Q?gJqcPsSJmITVI2vSRA5o+vnfMOprMnqNnY+RrNHUi424zRBOVmwEj0S1YGaa?=
 =?us-ascii?Q?EeLDb1sX0xoNjPhD1AbPngTeC5WWS9OlmsUj7ZkIY9cLZJAU43Q9rZIU7Wdq?=
 =?us-ascii?Q?q70C1E7ChALnwOFS4g0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bacf3a-6373-4d62-2022-08d9f6bd15b4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:10:22.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0S5yuI4J5ryKJIbwp7fFj9LCwsUZgmfh3izArxC71UYBKp57dUHUJJsYG2cvTUF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2863
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/23 18:30, Forza wrote:
>=20
>=20
> On 2/23/22 11:06, Qu Wenruo wrote:
>>
>>
>> On 2022/2/23 17:01, Forza wrote:
>>> Subject:
>>> Crash/BUG on during device delete
>>> From:
>>> Forza <forza@tnonline.net>
>>> Date:
>>> 2/23/22, 09:59
>>> To:
>>> linux-btrfs@vger.kernel.org
>>>
>>> Hi!
>>>
>>> I am running a test system and experienced a hard lockup with the
>>> following message:
>>>
>>> [53869.712800] BTRFS critical: panic in extent_io_tree_panic:689:
>>> locking error: extent tree was modified by another thread while locked
>>> (errno=3D-17 Object already exists)
>>> [53869.712825] kernel BUG at fs/btrfs/extent_io.c:689!
>>>
>>> Kernel: 5.15.16-0-lts #1-Alpine SMP
>>> CPU: Xeon(R) E-2126G
>>> MB: SuperMicro X11SCL-F, 64GB ECC RAM
>>> Broadcom 9500-8i HBA SAS controller
>>>
>>>
>>> I had 5 SSDs in a RAID1 filesystem and wanted to delete 3 of them.
>>>
>>> # btrfs device delete /dev/sdf /dev/sdd /dev/sdd /mnt/nas_ssd
>>>
>>> When about 6GB was left on the last device I got a kernel BUG message
>>> with stack trace. Unfortunately the message was not saved to syslog -
>>> anything trying to access the system disk froze, even though the "btrfs
>>> device delete" operation was not performed on the root filesystem. I
>>> managed to get some screenshots of the trace.
>>>
>>> I performed a hard reset and the system booted normally. A scrub showed
>>> no errors and a new "btrfs device delete /dev/sde /mnt/nas_ssd/"
>>> finished without errors.
>>>
>>> Attached images (wasn't able to send them to the list):
>>> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-2308335=
9.png=20
>>>
>>
>> =C2=A0From the stack, it looks like related to chunk discard optimizatio=
n?
>>
>> Can you provide the code line number of btrfs_alloc_chunk+0x570 and
>> add_extent_mapping+0x1c6?
>>
>> Better with the code context.
>>
>> Thanks,
>> Qu
>=20
> Hi Qu,
>=20
> I could only make the two screenshots as the system was frozen and logs=20
> were not saved to disk =3D(

No, I mean using linux/script/faddr2line to resolve the code line number=20
so we can have an idea on whether it's chunk discard optimization or=20
something else.

Thanks,
Qu
>=20
> *=20
> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083359.=
png=20
>=20
> * https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>=20
> Thanks.
>=20
>>>
>>> https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>>>
>>> I can do some further tests if needed. otherwise I need to deploy this
>>> system in about a week.
>>>
>>> Thanks.
>>>
>>>
>=20

