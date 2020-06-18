Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CF1FF12B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFRMFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:05:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56276 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFRMFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592481909; x=1624017909;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lxRErbIjeWVN9C8WSBD/mZ6PGUusvUcFXA5YMUSLVpE=;
  b=mB15dS3RIIgPQBBTPwQNh14URxZuMRGaz9vs+FkpOdcItRyQ4H0XmG0Y
   /qh7oEPlBUyXKVydmwstQOlO0mC4P1qdGrdr9Fo9k2jyXg9DlGlV9ScZk
   76EayEeXe6Z8C7Nmn5FQoFv0POZKHr9Ow3inGhaxlontCDilei6FAP1My
   /kyqUoEJQyU5BJCEaDjFDAhAwuk8/7xpSDKZVBgwsz+X61S4Vy8VwDOco
   n4h6nlheBpAaTSDvl+VDUlXl+e4XmXuzGcKa3IGyUQjz5StMaLm2XlU8l
   3nrjZ7xHkvQR6K7l0h+S9J33Rl8ZQYBc0ICT7WOEa3c3rEECVvACcE9zO
   g==;
IronPort-SDR: a0YxTuZ021mSXGpG+PxmsLSziTD9VlLR656Tb+p1FE/WH8BKyUlbE/ED4UqAdNOKvz8CLaL2zN
 NbMX+VgjX80E2gyU1PlHTrjOYLOH9uZraeL5x2uMXFuRH83BZ3w0t3I872qaz0WdInDNa8ya1v
 IHdtYayBy+PYmgArE/+FAOlzdfLMKCjXueEuwNxb+eM4ZtdykTiZui10qG+xB7E1SafNh337ba
 XWwcBOSzePmElVx1FG3wdBsy8IZ/9zTMbHGx5/gsMskiiWcZRFTrR1FhqeLRPgqItO+eEUPN+O
 /Vs=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; 
   d="scan'208";a="249494994"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 20:05:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSe3TPa5kaD3HCguQ5NHFtVFnLwbavgGl3UKrfrMdkjGilCOhfKfJ3O2Kr/F7axwyHt6CaQts3blPmmkdhknhpIP8vSZ09cAdpWeeP6Xol+XGNlbWMNHXDbm0/NeBXONqbDU6y1oNW6V/46QQVquc+xvSGhxhASP3D9oo3HKbi/Kp6NGvCxsLt4Uckbg/HGXqzr5OTXcMpi5JLcg9zIQ8TS2zryei4aeyhOyRt3XFprP+E6utX3uHpkGzmEkHu1TQmDaUpKOwL1ZglI3iW93zifwdTdeZ3faG/PYGr/hWqScsJgPOkwbFEDyVfUEsHwzd9aix5vIc6eHXSH7zkKxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+lLa+rzDtDRTAR8cGhTbKEmBm7o6XjaNhp99ny/dbo=;
 b=BvFvlu4svpf5flA0AeLHE0diEgCpCRRiEDKIEkC1wKTIzpgvhrC0PqDHvhIzXoBHmudV7jsKvnrKc0npnfVtXAwmvPXJE7Wrs28ZFp7w57SWJrHIvsRltGW4etwI0ZeL5FVp82BMFPH+EFcGazyYJVJRlRfEf/WftmFRpjdkuxPEYP2Hx4CvmirjYKCOmrlEjtNEuCubgJNHEjeQPVBnFg9n8V6Pd6QE9ymJVbgz5jnYzL7+EYPyIIvpt9uBh0lN//hK9MN2XhBPmOoKuVZcvkYiDZh2iNjGrk5xSpbpesiVIBBCyM5orahk+UvUe79negWArXQDNUIHvJEpEZdVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+lLa+rzDtDRTAR8cGhTbKEmBm7o6XjaNhp99ny/dbo=;
 b=k8OIdj2Ly4tFyKP+i3Fcrd4MhXIETSVT7JiUM1UXTK2Q945X2nFAQB0M+5r2eBIwHHLbpiXrhSCUhBYbJb/AYDP/gP4TfNgD2cNx9jv+JsLcid0m6SbG/lei1RoMSljFX8E0fI1EjtJwVrRzecdvaP1qcLilvGqdOA0zVxj/ahI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4784.namprd04.prod.outlook.com
 (2603:10b6:805:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 12:05:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 12:05:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two
 variants
Thread-Topic: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two
 variants
Thread-Index: AQHWRUUTafZBr9Wos02gKYnIZRraLw==
Date:   Thu, 18 Jun 2020 12:05:08 +0000
Message-ID: <SN4PR0401MB35988624F5193F3102ADB1579B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b137b0cd-01e8-4168-c021-08d8137fd84f
x-ms-traffictypediagnostic: SN6PR04MB4784:
x-microsoft-antispam-prvs: <SN6PR04MB4784386313DD3C8CEFBD10EF9B9B0@SN6PR04MB4784.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6HvFcwD+BEhPV7aDkGTPw4f7jeCBngAFsRs17P98GT96ccCnr1WDsJlcvUq2pb5JInHW3JuQaTZryI2Uzj5x3PeClrTgUkOmCfEG1+NpFCyYMb4uOWc/XF75s4kpAOXy3UFNfiCso/nR0UXYC3RBGlImVfTf4othNymzK4rKq3kyNYztmmTlYhgB7GI2IxuueqfLOb2pehFE1YAvEZ7v/ea2IRbmVNVwzSYvToz3LjNe5CaHmcHobU/OTMZhy2aEaZwZZzUpoC0wqDfQLPfdaHaeCZ8IboZyndZE5Gva9tpt4AfE0iAgco9GaktIiN2ST6wP45onDAueetWIhm8kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(71200400001)(5660300002)(316002)(83380400001)(9686003)(110136005)(8936002)(8676002)(478600001)(55016002)(186003)(66946007)(2906002)(66476007)(66556008)(86362001)(91956017)(7696005)(6506007)(53546011)(26005)(76116006)(66446008)(33656002)(52536014)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: p8BzBzGSUXAIjfpTBo7xBOqB8ISZy7XcBsFWVRgS5RGebCiLDZ/UCk+EF32FOni5URaLQxTs9zQx6/sN7hQ0lel6oyZh7N0AvXxLmPH/SGWj/ApYdX+kDW6/QnpGXvTBfFp8LveyajI2Qkh7tYnBMEmpsZzhlBa2aCgSN6ukp+nCqZNeA2VB1X+gBOJ36a93qPOpdlLYuGbbpZT93i7nPrnPA5n3aoARAu9zHT3YPsq+nq9XXjxvPEUf1zBE+BV3LThUXpExnbF9hfLYDDwztgpr52uszJNc6/EOrXocd5ODfy5ERz/7Js+Nm8MGO1OzhVQilwW61C73kgnAEpyQHbacwOe8goOUM9X0G7XyRTozDMTE5rC1yIn+6dlCoNSY56B4ub7Ziagjw6NzJEwzg8xnWCX784fZkiujuffXjchZXDdl1oocliK1/AvPiDw4QVKyz0rimv1BCThy6dXSGJ28SzVJqZQU+pUQjo8L7t67731SF2aTwPFTwHx27b1L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b137b0cd-01e8-4168-c021-08d8137fd84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 12:05:08.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XBEDAcloefHc7DHz3nSRntpGbKdXV7WYTMeWqt4rBEyGwCnNb8z/ECEQJnrWNMsCNLclvxRnEZE1G6wwz26S7OO1+GRfHHZ8/UlLM6py8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4784
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2020 09:50, Qu Wenruo wrote:=0A=
> The function check_can_nocow() now has two completely different call=0A=
> patterns.=0A=
> For nowait variant, callers don't need to do any cleanup.=0A=
> While for wait variant, callers need to release the lock if they can do=
=0A=
> nocow write.=0A=
> =0A=
> This is somehow confusing, and will be a problem if check_can_nocow()=0A=
> get exported.=0A=
> =0A=
> So this patch will separate the different patterns into different=0A=
> functions.=0A=
> For nowait variant, the function will be called try_nocow_check().=0A=
> For wait variant, the function pair will be start_nocow_check() and=0A=
> end_nocow_check().=0A=
=0A=
I find that try_ naming uneasy. If you take the example from locking =0A=
for instance, after a successful mutex_trylock() you still need to call=0A=
mutex_unlock().=0A=
=0A=
Maybe star_nowcow_check_unlocked() or start_nowcow_check_nowait() [though=
=0A=
the latter could imply it's putting things on a waitqueue] =0A=
=0A=
> =0A=
> Also, adds btrfs_assert_drew_write_locked() for end_nocow_check() to=0A=
> detected unpaired calls.=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
>  fs/btrfs/file.c    | 71 ++++++++++++++++++++++++++++------------------=
=0A=
>  fs/btrfs/locking.h | 13 +++++++++=0A=
>  2 files changed, 57 insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c=0A=
> index 0e4f57fb2737..7c904e41c5b6 100644=0A=
> --- a/fs/btrfs/file.c=0A=
> +++ b/fs/btrfs/file.c=0A=
> @@ -1533,27 +1533,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode=
 *inode, struct page **pages,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> -/*=0A=
> - * Check if we can do nocow write into the range [@pos, @pos + @write_by=
tes)=0A=
> - *=0A=
> - * This function will flush ordered extents in the range to ensure prope=
r=0A=
> - * nocow checks for (nowait =3D=3D false) case.=0A=
> - *=0A=
> - * Return >0 and update @write_bytes if we can do nocow write into the r=
ange.=0A=
> - * Return 0 if we can't do nocow write.=0A=
> - * Return -EAGAIN if we can't get the needed lock, or for (nowait =3D=3D=
 true) case,=0A=
> - * there are ordered extents need to be flushed.=0A=
> - * Return <0 for if other error happened.=0A=
> - *=0A=
> - * NOTE: For wait (nowait=3D=3Dfalse) calls, callers need to release the=
 drew write=0A=
> - * 	 lock of inode->root->snapshot_lock if return value > 0.=0A=
> - *=0A=
> - * @pos:	 File offset of the range=0A=
> - * @write_bytes: The length of the range to check, also contains the noc=
ow=0A=
> - * 		 writable length if we can do nocow write=0A=
> - */=0A=
> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t po=
s,=0A=
> -				    size_t *write_bytes, bool nowait)=0A=
> +static noinline int __check_can_nocow(struct btrfs_inode *inode, loff_t =
pos,=0A=
> +				      size_t *write_bytes, bool nowait)=0A=
>  {=0A=
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;=0A=
>  	struct btrfs_root *root =3D inode->root;=0A=
> @@ -1603,6 +1584,43 @@ static noinline int check_can_nocow(struct btrfs_i=
node *inode, loff_t pos,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check if we can do nocow write into the range [@pos, @pos + @write_by=
tes)=0A=
> + *=0A=
> + * The start_nocow_check() version will flush ordered extents before che=
cking,=0A=
> + * and needs end_nocow_check() calls if we can do nocow writes.=0A=
> + *=0A=
> + * While try_nocow_check() version won't do any sleep or hold any lock, =
thus=0A=
> + * no need to call end_nocow_check().=0A=
> + *=0A=
> + * Return >0 and update @write_bytes if we can do nocow write into the r=
ange.=0A=
> + * Return 0 if we can't do nocow write.=0A=
> + * Return -EAGAIN if we can't get the needed lock, or there are ordered =
extents=0A=
> + * needs to be flushed.=0A=
> + * Return <0 for if other error happened.=0A=
> + *=0A=
> + * @pos:	 File offset of the range=0A=
> + * @write_bytes: The length of the range to check, also contains the noc=
ow=0A=
> + * 		 writable length if we can do nocow write=0A=
> + */=0A=
> +static int start_nocow_check(struct btrfs_inode *inode, loff_t pos,=0A=
> +			     size_t *write_bytes)=0A=
> +{=0A=
> +	return __check_can_nocow(inode, pos, write_bytes, false);=0A=
> +}=0A=
> +=0A=
> +static int try_nocow_check(struct btrfs_inode *inode, loff_t pos,=0A=
> +			   size_t *write_bytes)=0A=
> +{=0A=
> +	return __check_can_nocow(inode, pos, write_bytes, true);=0A=
> +}=0A=
> +=0A=
> +static void end_nocow_check(struct btrfs_inode *inode)=0A=
> +{=0A=
> +	btrfs_assert_drew_write_locked(&inode->root->snapshot_lock);=0A=
> +	btrfs_drew_write_unlock(&inode->root->snapshot_lock);=0A=
> +}=0A=
> +=0A=
>  static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,=0A=
>  					       struct iov_iter *i)=0A=
>  {=0A=
> @@ -1668,8 +1686,8 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,=0A=
>  		if (ret < 0) {=0A=
>  			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |=0A=
>  						      BTRFS_INODE_PREALLOC)) &&=0A=
> -			    check_can_nocow(BTRFS_I(inode), pos,=0A=
> -					    &write_bytes, false) > 0) {=0A=
> +			    start_nocow_check(BTRFS_I(inode), pos,=0A=
> +				    	      &write_bytes) > 0) {=0A=
>  				/*=0A=
>  				 * For nodata cow case, no need to reserve=0A=
>  				 * data space.=0A=
> @@ -1802,7 +1820,7 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,=0A=
>  =0A=
>  		release_bytes =3D 0;=0A=
>  		if (only_release_metadata)=0A=
> -			btrfs_drew_write_unlock(&root->snapshot_lock);=0A=
> +			end_nocow_check(BTRFS_I(inode));=0A=
>  =0A=
>  		if (only_release_metadata && copied > 0) {=0A=
>  			lockstart =3D round_down(pos,=0A=
> @@ -1829,7 +1847,7 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,=0A=
>  =0A=
>  	if (release_bytes) {=0A=
>  		if (only_release_metadata) {=0A=
> -			btrfs_drew_write_unlock(&root->snapshot_lock);=0A=
> +			end_nocow_check(BTRFS_I(inode));=0A=
>  			btrfs_delalloc_release_metadata(BTRFS_I(inode),=0A=
>  					release_bytes, true);=0A=
>  		} else {=0A=
> @@ -1946,8 +1964,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *=
iocb,=0A=
>  		 */=0A=
>  		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |=0A=
>  					      BTRFS_INODE_PREALLOC)) ||=0A=
> -		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,=0A=
> -				    true) <=3D 0) {=0A=
> +		    try_nocow_check(BTRFS_I(inode), pos, &nocow_bytes) <=3D 0) {=0A=
>  			inode_unlock(inode);=0A=
>  			return -EAGAIN;=0A=
>  		}=0A=
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h=0A=
> index d715846c10b8..28995fccafde 100644=0A=
> --- a/fs/btrfs/locking.h=0A=
> +++ b/fs/btrfs/locking.h=0A=
> @@ -68,4 +68,17 @@ void btrfs_drew_write_unlock(struct btrfs_drew_lock *l=
ock);=0A=
>  void btrfs_drew_read_lock(struct btrfs_drew_lock *lock);=0A=
>  void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock);=0A=
>  =0A=
> +#ifdef CONFIG_BTRFS_DEBUG=0A=
> +static inline void btrfs_assert_drew_write_locked(struct btrfs_drew_lock=
 *lock)=0A=
> +{=0A=
> +	/* If there are readers, we're definitely not write locked */=0A=
> +	BUG_ON(atomic_read(&lock->readers));=0A=
> +	/* We should hold one percpu count, thus the value shouldn't be zero */=
=0A=
> +	BUG_ON(percpu_counter_sum(&lock->writers) <=3D 0);=0A=
> +}=0A=
> +#else=0A=
> +static inline void btrfs_assert_drew_write_locked(struct btrfs_drew_lock=
 *lock)=0A=
> +{=0A=
> +}=0A=
> +#endif=0A=
>  #endif=0A=
> =0A=
=0A=
