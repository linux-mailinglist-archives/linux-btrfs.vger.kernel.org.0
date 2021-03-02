Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5932B23D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbhCCB6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:07 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:32161 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382785AbhCBKQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 05:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614680116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRjycvWkEsl4nXw/AUKzkVX3KrTRdiA3aYfsnSGiL8k=;
        b=NHXZfEgohP9wDj53IH6dourP+DJsJMgFU8kAl1n0/x1KA0d8eEKHElzhOa3mLdVC/saLWk
        Xd+pI0E5BY9bdDBfBl9OPVfjt5L8Ok1hm/E+2/l1cR+YAyge/B0akF6Diyg0IxcnGzjGeg
        NIZbuuQhDiNcyBgCsN8cF++z1MsdcQU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-I2gmrVWZMXyOkc6TZLExoA-1; Tue, 02 Mar 2021 11:15:15 +0100
X-MC-Unique: I2gmrVWZMXyOkc6TZLExoA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHX5wCpjAEcdNUxVdZ4BhcDW1xuyiPWxHeeoLC08tq0DwERz9RtsICFt9I1ZWsbmXPsSZNmIwSMce4RVECN1fH6EdMFdVY+uQuhbFK1QIffCyRYhjUjGGiGSeKg7GMga3qt5tK9iMmckgV0/1NUa8BUpnL8P23hagfM8pk/D+nuTyYh7aW/PMUbiesMiKAHG4lYPzt0yq5kY6S+ckUnjUxTFz6luoGGfByhnF2PcAuBLv33bdj+JaH396tFp1cebpJFO8KfgEOiKRF5VG8w35SOwAxtqzUMASU1VT94sLtW4Y4fqIbarutA7S63OjqxtGMtqXSNdvimfieX7tHFTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=835+a4rAkkjb75BlWQJE2xuJaBk7CTVCr2sUm9RuKbE=;
 b=dypNrofzQAk54GnNKTASUwyvUulsbf/xNNt5Fjh6rErn3nYvN+h2OXgan27twtqY7jqAKJlFEZY9Xyyz4NH0/qXokXmWtZH8IrH4k5EVgxKmOcNmHTic04u4CdjTm5oF6vpNi4I3EnhMEj3UAva2Ua+f3oUZrCCriksjGUi8Jk1xEmSF9XKmWTlO81NE/FjmYK59hIdDiy1FMxPnqHC7xSv5cP2g4Rlwj8SB3vQCbzrdOaLXquzFraD5NzmFS3cSsdqnoyU/1MgVSYwmzFyaZyJyvcXDLCK/lXcNOIixVct8WjNZVLcc9Tv2Q1ITFEQYDdJ30T94O4sIcSOUeW1nLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3041.eurprd04.prod.outlook.com (2603:10a6:206:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 2 Mar
 2021 10:15:14 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::355a:d09c:cbf8:657e]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::355a:d09c:cbf8:657e%6]) with mapi id 15.20.3868.036; Tue, 2 Mar 2021
 10:15:14 +0000
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     linux-btrfs@vger.kernel.org
References: <20201109053952.490678-1-wqu@suse.com>
 <20201109053952.490678-2-wqu@suse.com>
 <20210302164758.28C1.409509F4@e16-tech.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs-progs: check: detect and warn about tree blocks
 cross 64K page boundary
Message-ID: <e478e495-e2f6-452d-c615-a7e1f32805e7@suse.com>
Date:   Tue, 2 Mar 2021 18:14:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210302164758.28C1.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0046.namprd06.prod.outlook.com (2603:10b6:a03:14b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 2 Mar 2021 10:15:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e1527e8-abf9-4402-f2dc-08d8dd641211
X-MS-TrafficTypeDiagnostic: AM5PR04MB3041:
X-Microsoft-Antispam-PRVS: <AM5PR04MB30415B3086EAE97ABEDD1DA7D6999@AM5PR04MB3041.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RobKMAZqWtsY8ertFzoBsBeySwk2n9M9mz708A7VYyf10oE9OfoAZcQIy81uigbBo4qRSvF46AII4/i9/SapNYpS0YWS+gjqKsjB43JfCUTwcrmOATid0WUbUUMLT4Dr6f5gW1H/LnkEAmpI4xuDxqghspubtfcJug7z84J+1UYaMUYkjo/Ihgp/PLRfwcmkH6KpXRyK8RH8MhDk7oxkvA2maiyqwkr+UNnzbOoENym+j44j9XA/hpdOj/gBdivN2obaZFxsHggsXtOmZHHwavBgV9oKZk/9rMSYe7SZRWoI65L+M9nKHlcL9tYSdfo8hE9QFGynrgRcUm1glfi9jKyq4yNp19bWPpT10k4iFn3teoYubn82NQJqY0SDqvj9ZgwqLAEet6NOkvTZriRF/03mfePAbGl+tNmn9JvKEiATnYYvMuKS46ooFF4PPBw5M9ZtrLV4Vk0LY+D3naiX6+ZiIOizEc0dFpMwjCts0a1NkPxhQdg1uxPTCAKBBirDU5kQoyk8ekZnljoqFwI6NWdx2ej/vwgjK+ctu7BkvSqr14Zxc2S68mFjd8TksKmRLyIh/jhOQVJNqeUTYI1YD2N4oDwDutjyYg2pFKPPFdMcx8q8qT/gYSNBlSrmFJ1b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39850400004)(346002)(376002)(66556008)(66946007)(66476007)(16526019)(186003)(52116002)(16576012)(316002)(8676002)(86362001)(6666004)(26005)(31696002)(6486002)(478600001)(6916009)(6706004)(36756003)(956004)(31686004)(2616005)(83380400001)(2906002)(8936002)(5660300002)(4326008)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pGq/h+KkREiDPG5jOZBSSLrmDsRwHPexL/gRylWBi2CFNDxiJSXMbBK4qTdp?=
 =?us-ascii?Q?eQCJkDtIcbYpyxcTHsri6Gk+6JEvfKJvNn9eb6W9SjswHxMFca4H3NssPaJt?=
 =?us-ascii?Q?FkGZ0ps+jknxTZhktVufAXP5R8CFLTXdNEz+49UiIjtY4GAISjnSW42Gyd3A?=
 =?us-ascii?Q?eAtHqlxlV1vUOMGhOWTuCjpBGwY4R0TyajXt3Giqr9iK42TzoThgcbbXGj8B?=
 =?us-ascii?Q?GDCEa+DOHl/iUScMybXZLMFqpSlkb8quRu12glYNPmZszMCH4Hg+B7ePRzQ1?=
 =?us-ascii?Q?oatxN5dBa5WQPPZwYl2ladC691wL0TnTNwytCDL9HuKJTMxmUiCrSeSVu1Si?=
 =?us-ascii?Q?hkRn9PSJUue3jti1SHfAbDTtxdWODvGLpfwVRx0L+SFFkLFwhgd+kBaOLsaX?=
 =?us-ascii?Q?k6g6XHXO5u6wm7NrqDFYsbPgL3Jv+7sJNDK1imCbhq5sNjGHNgAPv5TZ/CEN?=
 =?us-ascii?Q?gEj7qRvhP+zmN6+bjpLWMrw26D+YBE3fFQqTGOFiDrxc6huWNjwAfJM0/ftb?=
 =?us-ascii?Q?7XF1bsJbFOnGGNpJrExvKqm4/AFLxYKDBhI+kqmf6uMt3XX7mvV0dOEF/IPc?=
 =?us-ascii?Q?DJiYvo7keaFa4bQFtjX0c7S9t0W/pq8Adgvnk2ExTRdqNfC+aoNlbJUFhuqG?=
 =?us-ascii?Q?WoBOzFtrxZyhemXnvDimw3bDxIzVN72NmRN7X4BNE3aoKhCLY3YUUZ8iwUWh?=
 =?us-ascii?Q?zU9orwmGehJa9RkZGFuFjwnvgeSObVHHuIyZgpocSFndR7i4Nod0TJN9rNA7?=
 =?us-ascii?Q?YeY/09NWQaRj7nNwI6GzhuC5FKiq+vXv2J6pYpClZ9AqxjCPh3+8aswaKlUN?=
 =?us-ascii?Q?gD/K36JMIWOtq9dky3kAjI6LjQUmoO6zG+rw9P1VEYtQbTiuWPHT2RZi2fYy?=
 =?us-ascii?Q?ZzZV0L4Z1p2Hpg+H2PwjfVIyirIY5HJbPFWcSrWru4+zWxMrqoYoa7T9ZNLS?=
 =?us-ascii?Q?YraO7TQumEuHlMqfjwKXHri1u2JUUMz2IYx+VfUdMTbWG4Xx/I3de7Q/nAMY?=
 =?us-ascii?Q?pPVYn8ucMkO+L3BgHNbDz/Ye/vzO2kloS5Fj2wp8vGD5jI1uFJ56ZiUdG+SB?=
 =?us-ascii?Q?8NA5Rp/etuVhWKwBzrhhQXQugkrntEFFXdLqw6U/zpGqwoFiY2LP1ypN5f5C?=
 =?us-ascii?Q?5ik6FP8CsOBXFrk1UKLgKo6GmiOVVs8r56VTPsKABTWCQ5wCCwNcMY37Fzo/?=
 =?us-ascii?Q?vD8yNbnPNyW/EQ6OuWuy+Q/6FwfCiSu+0HJ14YPXEphAB/XY/1QcHhiKNPAv?=
 =?us-ascii?Q?d7MlLo0kP2ioFmzLKL7CBRYA8qF3zCZfwdigSKNPoJej60RX/zxzakhTEFsW?=
 =?us-ascii?Q?+i0siWAc2eD7lUcNLnOwiyTL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1527e8-abf9-4402-f2dc-08d8dd641211
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 10:15:14.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vswrBlDh8bUsWY7J5Yz2xphsGLrBePyX7FRtFtLe8zgRWoMa9eBqGPi1Wnwlasb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3041
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/2 =E4=B8=8B=E5=8D=884:48, Wang Yugui wrote:
> Hi, Qu Wenruo
>=20
> This warning message happen even in new created filesystem on amd64
> system.
>=20
> Should we slicent it before mkfs.btrfs is ready for  64K page system?

Nope.

If your fs reports such problem, it means your metadata chunk is not=20
properly aligned.

The behavior of chunk allocator alignment has been there for a long long=20
time, thus most metadata chunks should already been properly aligned to 64K=
.

Either btrfs kernel module or mkfs.btrfs has something wrong.


>=20
> The paration is aligned in 1GiB
>=20
> btrfs-progs: v5.10.x branch
>=20
> # mkfs.btrfs /dev/sdb1 -f
>=20

And running v5.10.1 I can't reproduce it.

> # btrfs check /dev/sdb1
> Opening filesystem to check...
> Checking filesystem on /dev/sdb1
> UUID: b298271d-6d1d-4792-a579-fb93653aa811
> [1/7] checking root items
> [2/7] checking extents
> WARNING: tree block [5292032, 5308416) crosses 64K page boudnary, may cau=
se problem for 64K page system
> WARNING: tree block [5357568, 5373952) crosses 64K page boudnary, may cau=
se problem for 64K page system

I doubt if you're really using v5.10.x mkfs.btrfs.

As for default btrfs, the metadata chunk is after DATA and SYS chunks,=20
this means metadata chunks should only exist after bytenr 16M, but here=20
your metadata is only at around 5M.

I strongly doubt your mkfs parameters.

Please attach the full mkfs output.

Thanks,
Qu

> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 147456 bytes used, no error found
> total csum bytes: 0
> total tree bytes: 147456
> total fs tree bytes: 32768
> total extent tree bytes: 16384
> btree space waste bytes: 140356
> file data blocks allocated: 0
>   referenced 0
>=20
> # parted /dev/sdb unit KiB print
> Model: TOSHIBA PX05SMQ040 (scsi)
> Disk /dev/sdb: 390711384kiB
> Sector size (logical/physical): 4096B/4096B
> Partition Table: gpt
> Disk Flags:
>=20
> Number  Start         End           Size         File system  Name     Fl=
ags
>   1      1048576kiB    63963136kiB   62914560kiB  btrfs        primary
>=20
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/03/02
>=20
>> For the incoming subpage support, there is a new requirement for tree
>> blocks.
>> Tree blocks should not cross 64K page boudnary.
>>
>> For current btrfs-progs and kernel, there shouldn't be any causes to
>> create such tree blocks.
>>
>> But still, we want to detect such tree blocks in the wild before subpage
>> support fully lands in upstream.
>>
>> This patch will add such check for both lowmem and original mode.
>> Currently it's just a warning, since there aren't many users using 64K
>> page size yet.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   check/main.c        |  2 ++
>>   check/mode-common.h | 18 ++++++++++++++++++
>>   check/mode-lowmem.c |  2 ++
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/check/main.c b/check/main.c
>> index e7996b7c8c0e..0ce9c2f334b4 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -5375,6 +5375,8 @@ static int process_extent_item(struct btrfs_root *=
root,
>>   		      num_bytes, gfs_info->sectorsize);
>>   		return -EIO;
>>   	}
>> +	if (metadata)
>> +		btrfs_check_subpage_eb_alignment(key.objectid, num_bytes);
>>  =20
>>   	memset(&tmpl, 0, sizeof(tmpl));
>>   	tmpl.start =3D key.objectid;
>> diff --git a/check/mode-common.h b/check/mode-common.h
>> index 4efc07a4f44d..bcda0f53e2c4 100644
>> --- a/check/mode-common.h
>> +++ b/check/mode-common.h
>> @@ -171,4 +171,22 @@ static inline u32 btrfs_type_to_imode(u8 type)
>>  =20
>>   	return imode_by_btrfs_type[(type)];
>>   }
>> +
>> +/*
>> + * Check tree block alignement for future subpage support on 64K page s=
ystem.
>> + *
>> + * Subpage support on 64K page size require one eb to be completely con=
tained
>> + * by a page. Not allowing a tree block to cross 64K page boudanry.
>> + *
>> + * Since subpage support is still under development, this check only pr=
ovides
>> + * warning.
>> + */
>> +static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
>> +{
>> +	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=3D
>> +	    (start + len) / BTRFS_MAX_METADATA_BLOCKSIZE)
>> +		warning(
>> +"tree block [%llu, %llu) crosses 64K page boudnary, may cause problem f=
or 64K page system",
>> +			start, start + len);
>> +}
>>   #endif
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index 2b689b2abf63..6dbfe829bb7c 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -4206,6 +4206,8 @@ static int check_extent_item(struct btrfs_path *pa=
th)
>>   		      key.objectid, key.objectid + nodesize);
>>   		err |=3D CROSSING_STRIPE_BOUNDARY;
>>   	}
>> +	if (metadata)
>> +		btrfs_check_subpage_eb_alignment(key.objectid, nodesize);
>>  =20
>>   	ptr =3D (unsigned long)(ei + 1);
>>  =20
>> --=20
>> 2.29.2
>=20
>=20

