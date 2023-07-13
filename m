Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF27529DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjGMRbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMRbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:31:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9FE74
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:31:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso881899276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689269495; x=1691861495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hBWKlMEX+dU+8cAxxVFCZpenkEU/aQe/Fu75QewWRM=;
        b=r4zz1MFmrdtKsrVUDbSIDQzCEczjwS4cb7yGq2MJrPTwAm8X9HxAxhWyyWcwijM0fh
         rp2ybVaKKkcThwCT/ESLgtO4tAYYun0v2XzppCbLansfQnSOPO1dlUzecVoGM6M4SFtc
         b7cySSJr+BnqaygeJk00MhE810mYQXgwiGBEx340irXiqZuuE6Ml/ru5OTjr0dpWHMzp
         iuzkwZAzuvG7YV8vR+AAwIqMWAVRREpygJ29LQNcjoFv/ZD7+ioV02Gtu+L+UNgBQr0A
         ZSdNz5qyIqnegj3ABsev2EPkh7TDjk79qDkeyUuHuZsOcvj/Eso7tJKoLFVHc6x7xurj
         Ji2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269495; x=1691861495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hBWKlMEX+dU+8cAxxVFCZpenkEU/aQe/Fu75QewWRM=;
        b=TgAup4scsWjhJBaIaFcHXSM5j34Fm2AeywQUnEKwAqbUCpOtyP7KnfNDrMO5hIzKTk
         WMZfjwKkPBPi116GhAgPL2VQCcqmrAmuo9JnJjcwc8cBvTtWu3za9eRuYhUg1aPMGiRI
         ik6cFI3wHLagw3l2Wad1Gi7iFnqwe3sEDagANoUr+Ep4bPbiMU0fooBr5/ifiobNdl4c
         8Mq0EYvdppV9gYTeVCGGgk2dNiwFP/Vxsiizp/nwQNNhOgkP7Q0rSuNaIHJcT+c7GKzZ
         b3L7NM/RZYZFRVDf9tfOoqZKR1gLUxhraNYjO0YPsz0hGiq6DZQDGYxXzXHUg5syYY2Z
         hPEw==
X-Gm-Message-State: ABy/qLbOpghSXZcs0mpWRk8qBOu0F4bw6uAfZ0EPNxvMOriB1IwJIvYM
        cls75takClAJbrLTUrwL8uzuMw==
X-Google-Smtp-Source: APBJJlFXiDVziNO7TjZSE2DKyeK1ieF6tvCWoWmHwucQDHtjfh20k7qDkiVnNK0fBj5iUySJlhIw4g==
X-Received: by 2002:a25:8249:0:b0:c4e:48eb:b8cb with SMTP id d9-20020a258249000000b00c4e48ebb8cbmr1788960ybn.40.1689269495151;
        Thu, 13 Jul 2023 10:31:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r14-20020a255d0e000000b00c602b4b7226sm1432679ybb.25.2023.07.13.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:31:34 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:31:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 17/18] btrfs: track metadata relocation cow with simple
 quota
Message-ID: <20230713173134.GQ207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <100b6185fc66f98c72cb8ad93092aba193b681e6.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100b6185fc66f98c72cb8ad93092aba193b681e6.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:54PM -0700, Boris Burkov wrote:
> Relocation cows metadata blocks in two cases for the reloc root:
> - copying the subvol root item when creating the reloc root
> - copying a btree node when there is a cow during relocation
> 
> In both cases, the resulting btree node hits an abnormal code path with
> respect to the owner field in its btrfs_header. It first creates the
> root item for the new objectid, which populates the reloc root id, and
> it at this point that delayed refs are created.
> 
> Later, it fully copies the old node into the new node (including the
> original owner field) which overwrites it. This results in a simple
> quotas mismatch where we run the delayed ref for the reloc root which
> has no simple quota effect (reloc root is not an fstree) but when we
> ultimately delete the node, the owner is the real original fstree and we
> do free the space.
> 
> To work around this without tampering with the behavior of relocation,
> add a parameter to btrfs_add_tree_block that lets the relocation code
> path specify a different owning root than the "operating" root (in this
> case, owning root is the real root and the operating root is the reloc
> root). These can naturally be plumbed into delayed refs that have the
> same concept.
> 
> Note that this is a double count in some sense, but a relatively natural
> one, as there are really two extents, and the old one will be deleted
> soon. This is consistent with how data relocation extents are accounted
> by simple quotas.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
