Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51C57284C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 23:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGLVNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiGLVNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 17:13:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D426BD8
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 14:13:37 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CL8VAa014941
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 14:13:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=facebook;
 bh=Y9DSj1AWVpuWLtI2syzA0F0XAXL4E+p2diffvjYGkUU=;
 b=ImPWnZ4GBmA9d6lsbrOvSQgUq0R6Cx5zJXw0GuQVs3rdLhk9aH1Do7+2S1E3SxGnv9oF
 Y5shI07w7cQF1FN9TZqD7KfaobVPHcU52QNXX3cvu4F+2jK/0knc5crP5EcRQ33rLrML
 3f2qUitfVa7KYrCDNP2DWSvxjMC71Fy5WJk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h8nndj4pj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 14:13:37 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 14:13:35 -0700
Received: by devbig009.nao1.facebook.com (Postfix, from userid 431575)
        id 8A2236A8D709; Tue, 12 Jul 2022 14:13:34 -0700 (PDT)
Date:   Tue, 12 Jul 2022 14:13:34 -0700
From:   Rohit Singh <rh0@fb.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: simplify error handling in btrfs_lookup_dentry
Message-ID: <Ys3j/s/h3SEExtOA@fb.com>
References: <20220711151618.2518485-1-nborisov@suse.com>
 <Ys3Rdl7HrV+bbtmB@fb.com>
 <4ceb1340-0844-53d9-3e24-660f50019a1c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4ceb1340-0844-53d9-3e24-660f50019a1c@suse.com>
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: Y_VIq0W39fGCFwufXKRPLymE5zPjguV7
X-Proofpoint-ORIG-GUID: Y_VIq0W39fGCFwufXKRPLymE5zPjguV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 12, 2022 at 11:36:00PM +0300, Nikolay Borisov wrote:
>=20
>=20
> On 12.07.22 =D0=B3. 22:54 =D1=87., Rohit Singh wrote:
> > On Mon, Jul 11, 2022 at 06:16:18PM +0300, Nikolay Borisov wrote:
> > > In btrfs_lookup_dentry releasing the reference of the sub_root and =
the
> > > running orphan cleanup should only happen if the dentry found actua=
lly
> > > represents a subvolume. This can only be true in the 'else' branch =
as
> > > otherwise either fixup_tree_root_location returned an ENOENT error,=
 in
> > > which case sub_root wouldn't have been changed or if we got a diffe=
rent
> > > errno this means btrfs_get_fs_root couldn't have executed successfu=
lly
> > > again meaning sub_root will equal to root. So simplify all the bran=
ches
> > > by moving the code into the 'else'.
> > >=20
> > > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > > ---
> > >   fs/btrfs/inode.c | 4 ----
> > >   1 file changed, 4 deletions(-)
> > >=20
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 0b17335555e0..1dd073e96696 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -5821,11 +5821,7 @@ struct inode *btrfs_lookup_dentry(struct ino=
de *dir, struct dentry *dentry)
> > >   			inode =3D new_simple_dir(dir->i_sb, &location, sub_root);
> > >   	} else {
> > >   		inode =3D btrfs_iget(dir->i_sb, location.objectid, sub_root);
> > > -	}
> > > -	if (root !=3D sub_root)
> > >   		btrfs_put_root(sub_root);
> > > -
> > > -	if (!IS_ERR(inode) && root !=3D sub_root) {
> >=20
> > It looks like the root !=3D sub_root stuff looks correct.
> >=20
> > Can't the btrfs inode have an error state on it though?
>=20
> Yes it can, under low memory condition. So I guess the correct version =
would be:
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0b17335555e0..44a2f38b2de0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5821,18 +5821,16 @@ struct inode *btrfs_lookup_dentry(struct inode =
*dir, struct dentry *dentry)
>                         inode =3D new_simple_dir(dir->i_sb, &location, =
sub_root);
>         } else {
>                 inode =3D btrfs_iget(dir->i_sb, location.objectid, sub_=
root);
> -       }
> -       if (root !=3D sub_root)
>                 btrfs_put_root(sub_root);
> -
> -       if (!IS_ERR(inode) && root !=3D sub_root) {
> -               down_read(&fs_info->cleanup_work_sem);
> -               if (!sb_rdonly(inode->i_sb))
> -                       ret =3D btrfs_orphan_cleanup(sub_root);
> -               up_read(&fs_info->cleanup_work_sem);
> -               if (ret) {
> -                       iput(inode);
> -                       inode =3D ERR_PTR(ret);
> +               if (!IS_ERR(inode)) {
> +                       down_read(&fs_info->cleanup_work_sem);
> +                       if (!sb_rdonly(inode->i_sb))
> +                               ret =3D btrfs_orphan_cleanup(sub_root);
> +                       up_read(&fs_info->cleanup_work_sem);
> +                       if (ret) {
> +                               iput(inode);
> +                               inode =3D ERR_PTR(ret);
> +                       }
>                 }
>         }
>=20

Looks good!

Reviewed-by: Rohit Singh <rh0@fb.com>
