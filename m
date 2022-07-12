Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBACE5726C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiGLTzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 15:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGLTy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 15:54:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7112E7
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 12:54:36 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26CIsTXH004764
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 12:54:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=0Q/IF2rfed6v4Pmztz1rQVQTkTomcey+mM1/XXeaMqM=;
 b=j+tdTE9jARkncWwKoTfXJsnbgfyiG/iaUxrEXipYlABq1M24AQU2pahmE9zxyxMNN9Sn
 tv2nvC4NJMiUwyn3lZjO43/3BHCRlRJKujPTrguY/nmp8I6cgfD/6kB+Uhe0NagXOBmG
 kysh9Fl80DFyHy8FPmupXozaOIGEHdVHvsU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h94044m86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 12:54:35 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 12:54:35 -0700
Received: by devbig009.nao1.facebook.com (Postfix, from userid 431575)
        id 402646A811AC; Tue, 12 Jul 2022 12:54:30 -0700 (PDT)
Date:   Tue, 12 Jul 2022 12:54:30 -0700
From:   Rohit Singh <rh0@fb.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: simplify error handling in btrfs_lookup_dentry
Message-ID: <Ys3Rdl7HrV+bbtmB@fb.com>
References: <20220711151618.2518485-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220711151618.2518485-1-nborisov@suse.com>
X-FB-Internal: Safe
X-Proofpoint-GUID: Rq_Ernbnizyib9uUTy7lIA4_uGxiSowM
X-Proofpoint-ORIG-GUID: Rq_Ernbnizyib9uUTy7lIA4_uGxiSowM
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

On Mon, Jul 11, 2022 at 06:16:18PM +0300, Nikolay Borisov wrote:
> In btrfs_lookup_dentry releasing the reference of the sub_root and the
> running orphan cleanup should only happen if the dentry found actually
> represents a subvolume. This can only be true in the 'else' branch as
> otherwise either fixup_tree_root_location returned an ENOENT error, in
> which case sub_root wouldn't have been changed or if we got a different
> errno this means btrfs_get_fs_root couldn't have executed successfully
> again meaning sub_root will equal to root. So simplify all the branches
> by moving the code into the 'else'.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0b17335555e0..1dd073e96696 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5821,11 +5821,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
>  			inode = new_simple_dir(dir->i_sb, &location, sub_root);
>  	} else {
>  		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
> -	}
> -	if (root != sub_root)
>  		btrfs_put_root(sub_root);
> -
> -	if (!IS_ERR(inode) && root != sub_root) {

It looks like the root != sub_root stuff looks correct.

Can't the btrfs inode have an error state on it though?
