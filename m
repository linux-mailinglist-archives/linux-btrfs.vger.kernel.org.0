Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1377FC6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353772AbjHQQ6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353831AbjHQQ6h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 12:58:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13FA2D67
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 09:58:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58c656824c1so395567b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692291515; x=1692896315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPfbwT5lP7oF8sr3fFtMy1piLFYVDYQGf7F5OxaBsLA=;
        b=kmpvmV/nSoSRtn95qai/zi6Dx895sII/IQfkW9Kr9r1MgnYKy3aywgZV0QEGPAUqKQ
         saGC8aplb5hyE4VPboitoorcJnWfTJKvopTUP73FVyqUmbYXtq3TV8jS2lQxER0NfqnV
         +KET1YClH0Na4lOVn1y4mdVSo+AmIptIgx3N6ScM5ubbiaKgroMBXcw6581oXAzHT4fo
         3HaYAgMCZzJGRn1Mm2lhZtWJVpaxrge9/fzB09YOaJd2gBzk6j1y4pKtG8Eg0D6r0hxG
         SyozquNG9Y3O4oI7riQG7PKNt+u1tZwIgHOrNVsZkQfH5hdd0uK3hrjA/kI37M+dhFVc
         AhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291515; x=1692896315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPfbwT5lP7oF8sr3fFtMy1piLFYVDYQGf7F5OxaBsLA=;
        b=ZJsj62zljHbcBJHBYVszNNFoYc0ezfzbwGNorK6Q85DUUPxopGSYShGJXORTcI3MVU
         w7diQhuC6UoFOYEEj7DS8WhFOpZ+LKx4p8VFKRjBCvS/q3MNAxRkf5HA/ECrlh1bmlXN
         nw3OqJX+G85FVUKjibkPpFUZngYJ7XqVVTqSntM9Jp4alJb8JlPNQkaGCaxvTLGOv0Zo
         sOcVSdKI+wDk+WvzVyWNCEpS0jiDs0N6Cox+mOZ/9b3etc2s/urFL6tpgOFBZF9dvG5+
         j+/FGyw4xNcoTlwL6V9L0lWPQuwzhYxpw/vgOFR93yr85rR9x8iwcU3J2/70RmNnQjZM
         XH4g==
X-Gm-Message-State: AOJu0Yz92qIY4uSSIU2o4+3Xylev/5Tql8Udg8d6QhkHv9B6qP+uQOEe
        dixVIGBafLN8ranfRv/lamWaVw==
X-Google-Smtp-Source: AGHT+IHrMoQN21D09izpb0BbTbcUmonBnGXyP0oQnb9jFxMr0xhuSY6w3oPmCIaq7D5DJAA6IHa+3Q==
X-Received: by 2002:a81:6946:0:b0:589:9ed0:5178 with SMTP id e67-20020a816946000000b005899ed05178mr6183683ywc.13.1692291515120;
        Thu, 17 Aug 2023 09:58:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k185-20020a0dc8c2000000b005773ca61111sm4727516ywd.42.2023.08.17.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:58:34 -0700 (PDT)
Date:   Thu, 17 Aug 2023 12:58:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Message-ID: <20230817165833.GA2935315@perftesting>
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <20230817154127.GB2934386@perftesting>
 <b49d3f4c-4b3d-06f4-7a37-7383af0781d0@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49d3f4c-4b3d-06f4-7a37-7383af0781d0@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 01:20:55PM -0300, Guilherme G. Piccoli wrote:
> On 17/08/2023 12:41, Josef Bacik wrote:
> >> [...]
> >> +	pr_info("BTRFS: virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
> >> +		disk_super->fsid, path, disk_super->metadata_uuid);
> > 
> > I think just
> > 
> > btrfs_info(NULL, "virtual fsid....")
> > 
> > is fine here.
> > 
> 
> So just for my full understanding, do you think we shouldn't show the
> real fsid here, but keep showing the virtual one, right? Or you prefer
> we literally show "virtual fsid...."?

Oh no sorry, just swap pr_info for btrfs_info, and keep the rest the same, so

	btrfs_info("virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
		   disk_super->fsid, path, disk_super->metadata_uuid);

thanks,

Josef
