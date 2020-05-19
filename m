Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD041D8D86
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgESCPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 22:15:48 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:44984 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgESCPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 22:15:48 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue, 19 May 2020 02:14:52 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 19 May 2020 02:14:59 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 19 May 2020 02:15:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK0tNXLYXF3YB4nY9YBYQnDpjFbpp/k8j3Bc5W/2uILvPsSqukfQT5rGhTOukKdvKD/LeAMHB5Oj5fZ9Pjmt/DiAUZkGszoS2t53cmL+pG1ssDJkacFJj3UbCQ23IyA+3MsVxnc+QawNnCTj5nH4jMHI9Rcv4OZCy587acDixEx7S3JhhP0w24iq+mlOOK0t4ZQhVtk7djOTp7teHVHGtaEc5wjawPoMTGuz7I85vqOaHIDOxRCkdRzQpl+Nm8IqgzkIPqLCQydy5LXUm4cZoKWHjz0xDkzU35JuixoO59pCSlt44j7EroPc1E4kfHbDk9je4diWr46gkEw39o9RIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bZ8sIuZuL/M5R/MnaMQRu90c/aggqqiwalb/hdhiVw=;
 b=SBzUR21IC/srSCi0RLIxIGCmnVafEp7TaKVboVCcs1be/h/Z9mImCKZDPhehlVIagolgSZ1j2g+whkA0DBST23r8M8z4ytyk/++gsq93BduAOQcCGYK8YgNpWqo6PBxgUbl5pVcknKQAVaZyJeNRreFZ/X6XU2OHHZ7uPQiv6zn+0gN/VOOIkPhDGgLLuJ3SMWnhq+OI2o36ugyIcsXGeXMkl1bs5KMCgqbvTJOgIl17sTf+ZYRtExg4DOHoAa7oNYQ6vOYFDgYLochYVMXyGNOI8xg1HVPnwrK9zOJjBHWZqFrvIrl8waGNFLr9zbOjfvxO65cvZ7EobPTnkDBNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB3637.namprd18.prod.outlook.com (2603:10b6:208:24e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 02:14:57 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.3000.033; Tue, 19 May 2020
 02:14:57 +0000
Subject: Re: [PATCH] btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage
From:   Qu Wenruo <wqu@suse.com>
To:     <linux-btrfs@vger.kernel.org>
References: <20200519021320.13979-1-wqu@suse.com>
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
Message-ID: <db8dafea-7a1c-0ac6-dddc-b29bdbd5c0a9@suse.com>
Date:   Tue, 19 May 2020 10:14:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200519021320.13979-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="laIPH1xAgGPDea7LVtHVkVH1XSGO2cdDD"
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To MN2PR18MB2416.namprd18.prod.outlook.com
 (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 02:14:55 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ceedb7-cda6-4fc6-af27-08d7fb9a6ccf
X-MS-TrafficTypeDiagnostic: MN2PR18MB3637:
X-Microsoft-Antispam-PRVS: <MN2PR18MB363717CDFCC7C3A3B6BDA9FBD6B90@MN2PR18MB3637.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFZrb8KGIcfMAAjjegaIJvB0+wGnnLlCUmOXwdeyX5bjfWf0MVI/moQP4oLD71qIvcvHHZu71wU/u87RjGYVnO5KPxNo0uufuHPNMXWdund21aNY0xJqJx8huLNzFm7xVQuP0V5XWlI4GV3u23Zmaq965r2E8DqoG9Ucv/jrK7TaDz522VW11KL64I+/sflN4y5ktmujXvnAJ7BzQIwrGSEFudZ/47ydtHUs2XICo8CNUeVf0wnWw6HQLtUtj2F6ylliBXS7q0dAHwnZZQ2fJHuJa8mAOE61ONFDvg8l3DvUp1dz+D6meggLQFvTLbj00RMThDcuS6vzvch/ppLqUWOT9WGpkZNjm6S502ZESQkIIGyLAe3jglEDu1/z8yREqdRswOkkUTN28OyszN0JpiNSUPFJBqDzrd1RXtk4TBwY7ttRvrZ48oMNDLuokrn9Ym8rZZSmvHAzGfxLQDwrrAdDwS2epZLd+iSun22wVDvLCuSqFn4KsN+6kLNrES14lb/YA3Cz2wNl4t/RJajnUbZRrVbj0ErkbXWU4uN9vEPRRC+2QKcY7717Snrfe1/2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(26005)(21480400003)(6706004)(186003)(36756003)(6486002)(16526019)(8936002)(66556008)(66476007)(33964004)(66946007)(8676002)(52116002)(16576012)(316002)(6666004)(31696002)(31686004)(6916009)(478600001)(2906002)(86362001)(956004)(5660300002)(235185007)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ugsVSEsIXPzJL8oiIKooMOUY4vhH3S6Bb6uIl1nyOrXNtkIF96f+fBZw+hIK3RWibhQ1rViBQ8zPn9r1yAR9EZTr9TDiH6CZj+f0bG9pXKytFokbG8g1yXwQHZxPBdswY2jOcRss96zC8MRV7HLUP51U8087I/mQxe/Vn/nW2IfV/NLvJIMOFZNXctRy6Mc0EN4lVZl63DHWPMfNoUDgXunbADH2Ibm4Z5DO5LSDHMAlj7dPiHXbbsiii5XD35CZ98BrtHizf9eUDBtG5eLGm6ZXozHreVil9saO8+7ygnuFXCVx5S3BG0joLSpDsVJ9Vsm39WhrgJdeNDdIfH4bTAzWZsEgfbWHcbT5pkj9s0HowT1lAXfLWnhktR+5lP55iPiPJdF6Vd+s0Y9qsLJOzh98d+nZVAjCmmdbh8THQj0HnzRWOqXmHouFxFWQ84s1eDI2abig4MAAGmaemY+Nk7RSK9md7FRy4HpiJrdECTU=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ceedb7-cda6-4fc6-af27-08d7fb9a6ccf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 02:14:57.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5PFGND1tpKX/j+BrhF4vTmoJ1xKCdXofsA4xp5/MwA/bdqutbptCPSPSGLfWs6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3637
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--laIPH1xAgGPDea7LVtHVkVH1XSGO2cdDD
Content-Type: multipart/mixed; boundary="BE4O97g0QUvIR3z7offDFrqzUBSq4bFnM"

--BE4O97g0QUvIR3z7offDFrqzUBSq4bFnM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/19 =E4=B8=8A=E5=8D=8810:13, Qu Wenruo wrote:
> [BUG]
> When balance is canceled, there is a pretty high chance that unmounting=

> the fs can lead to lead the NULL pointer dereference:
>=20
>   BTRFS warning (device dm-3): page private not zero on page 223158272
>   ...
>   BTRFS warning (device dm-3): page private not zero on page 223162368
>   BTRFS error (device dm-3): leaked root 18446744073709551608-304 refco=
unt 1
>   BUG: kernel NULL pointer dereference, address: 0000000000000168
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 2 PID: 5793 Comm: umount Tainted: G           O      5.7.0-rc5-c=
ustom+ #53
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/=
2015
>   RIP: 0010:__lock_acquire+0x5dc/0x24c0
>   Call Trace:
>    lock_acquire+0xab/0x390
>    _raw_spin_lock+0x39/0x80
>    btrfs_release_extent_buffer_pages+0xd7/0x200 [btrfs]
>    release_extent_buffer+0xb2/0x170 [btrfs]
>    free_extent_buffer+0x66/0xb0 [btrfs]
>    btrfs_put_root+0x8e/0x130 [btrfs]
>    btrfs_check_leaked_roots.cold+0x5/0x5d [btrfs]
>    btrfs_free_fs_info+0xe5/0x120 [btrfs]
>    btrfs_kill_super+0x1f/0x30 [btrfs]
>    deactivate_locked_super+0x3b/0x80
>    deactivate_super+0x3e/0x50
>    cleanup_mnt+0x109/0x160
>    __cleanup_mnt+0x12/0x20
>    task_work_run+0x67/0xa0
>    exit_to_usermode_loop+0xc5/0xd0
>    syscall_return_slowpath+0x205/0x360
>    do_syscall_64+0x6e/0xb0
>    entry_SYSCALL_64_after_hwframe+0x49/0xb3
>   RIP: 0033:0x7fd028ef740b
>=20
> [CAUSE]
> When balance is canceled, all reloc roots are marked orphan, and orphan=

> reloc roots are going to be cleaned up.
>=20
> However for orphan reloc roots and merged reloc roots, their lifespan
> are quite different:
> 	Merged reloc roots	|	Orphan reloc roots by cancel
> --------------------------------------------------------------------
> create_reloc_root()		| create_reloc_root()
> |- refs =3D=3D 1			| |- refs =3D=3D 1
> 				|
> btrfs_grab_root(reloc_root);	| btrfs_grab_root(reloc_root);
> |- refs =3D=3D 2			| |- refs =3D=3D 2
> 				|
> root->reloc_root =3D reloc_root;	| root->reloc_root =3D reloc_root;
> 		>>> No difference so far <<<
> 				|
> prepare_to_merge()		| prepare_to_merge()
> |- btrfs_set_root_refs(item, 1);| |- if (!err) (err =3D=3D -EINTR)
> 				|
> merge_reloc_roots()		| merge_reloc_roots()
> |- merge_reloc_root()		| |- Doing nothing to put reloc root
>    |- insert_dirty_subvol()	| |- refs =3D=3D 2
>       |- __del_reloc_root()	|
>          |- btrfs_put_root()	|
>             |- refs =3D=3D 1	|
> 		>>> Now orphan reloc roots still have refs 2 <<<
> 				|
> clean_dirty_subvols()		| clean_dirty_subvols()
> |- btrfs_drop_snapshot()	| |- btrfS_drop_snapshot()
>    |- reloc_root get freed	|    |- reloc_root still has refs 2
> 				|	related ebs get freed, but
> 				|	reloc_root still recorded in
> 				|	allocated_roots
> btrfs_check_leaked_roots()	| btrfs_check_leaked_roots()
> |- No leaked roots		| |- Leaked reloc_roots detected
> 				| |- btrfs_put_root()
> 				|    |- free_extent_buffer(root->node);
> 				|       |- eb already freed, caused NULL
> 				|	   pointer dereference
>=20
> [FIX]
> The fix is to clear fs_root->reloc_root and put it at
> merge_reloc_roots() time, so that we won't leak reloc roots.
>=20
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion afte=
r merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Extra note, this patch is not fixing the runaway balance.
But I can reproduce it reliably, it's not that far away.

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9afc1a6928cf..420348606123 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1917,12 +1917,11 @@ void merge_reloc_roots(struct reloc_control *rc=
)
>  		reloc_root =3D list_entry(reloc_roots.next,
>  					struct btrfs_root, root_list);
> =20
> +		root =3D read_fs_root(fs_info,
> +				    reloc_root->root_key.offset);
>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
> -			root =3D read_fs_root(fs_info,
> -					    reloc_root->root_key.offset);
>  			BUG_ON(IS_ERR(root));
>  			BUG_ON(root->reloc_root !=3D reloc_root);
> -
>  			ret =3D merge_reloc_root(rc, root);
>  			btrfs_put_root(root);
>  			if (ret) {
> @@ -1932,6 +1931,14 @@ void merge_reloc_roots(struct reloc_control *rc)=

>  				goto out;
>  			}
>  		} else {
> +			if (!IS_ERR(root)) {
> +				if (root->reloc_root =3D=3D reloc_root) {
> +					root->reloc_root =3D NULL;
> +					btrfs_put_root(reloc_root);
> +				}
> +				btrfs_put_root(root);
> +			}
> +
>  			list_del_init(&reloc_root->root_list);
>  			/* Don't forget to queue this reloc root for cleanup */
>  			list_add_tail(&reloc_root->reloc_dirty_list,
>=20


--BE4O97g0QUvIR3z7offDFrqzUBSq4bFnM--

--laIPH1xAgGPDea7LVtHVkVH1XSGO2cdDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7DQRwACgkQwj2R86El
/qjfRgf/eX7+7wQZzU6tfLe4hxiOAYkaH/KvsB+yqqqkC/nneTErlbG+Jf471cJ7
fFf0/4aSSgMuoa+MEG5wZGFtOPBTXyLUA4mdwp6j8lvKwXwEezZHn0tKzq17Ka3W
SjBGcAaAhEYClucjUMqnY156RKpsgfIcT/8AR6v/3a8hAbLcMqD1EjxA1DcPMON5
vh1Yknck0DXGOklxZXAGsA7XKjH/zRWzxGdKozJjROK8y8EODgtbK1m3SK3Vrcjf
aNNN8RKMaE8s1jq4vVSL/Vr+EkRBJYnDqbwD6k0iDjk70ptSjpSGdMZ3LWBT2c+j
IRUSCirXnmc8YU806de6prTx1HSkAg==
=4h/D
-----END PGP SIGNATURE-----

--laIPH1xAgGPDea7LVtHVkVH1XSGO2cdDD--
