Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04E7778ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjHJM7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjHJM7o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 08:59:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171442691
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 05:59:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4103393a459so936281cf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691672382; x=1692277182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxRkDZ5mi4r6Fqh/EIkLkHENKglqVvYUtdakPGwF2oQ=;
        b=Rz8UH/dTfi2PPcl2QNRCkGWcrETQAP46mNlO8lu6/Ax1g8FQLJucNrDHgZGgomBNwE
         oeyWf6MvTS8hkbKiCrJyYbd0Bkkn8NPfyzFn+jNAWCkxjzqfpea1D97JWebNuF67Q63X
         CuqMLojOsgIxqhwRZmyOIgcAqejm4xt7zpYUCEgPgCllJHPhVe8ZOd8P+rKUlpUkbdJO
         7MhtWXGjL8JHYVkC3idDHsoPV4NKSMvme+DbAhiVOKvqk9e20olQ8DESG/cO5wnKn1rW
         tTg2V/go5fVaiApTzSOlTjZyGRZquG4il5x5mQMKhuzVMfmO/X7xsl7mURs1zkKQwR+M
         TfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691672382; x=1692277182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxRkDZ5mi4r6Fqh/EIkLkHENKglqVvYUtdakPGwF2oQ=;
        b=kRvXnZkGoCs9r7AgZBg7c0UUBZCcqW42Piv4uxsCh/u91Iilpe5eaTUL5bAVSYvvzt
         oHFjJuXLZ3AZUX8443OyuHvNXwW7ZF6QN5AgxrWae/dZdSaHKvnAgL7B+orUwRqVtXvu
         71N4V25TrzGuacl6L1PQVh1NR1JvLGxvS5Pdqnb19Kle4gVaxYf3NuSuFgrl0eZzqyNt
         zF+qvvWeKo6fwe4mdVt4Y1UWGrAlUHCjUgPcC74FR8+AnoX3LOVFUXTxnApHFGO4ixrg
         B3YitJ0FQXyV/uz6OnjJGlQ4gYiil8KZWCt9s1hENwTsLeQIDYxgOc1P7kqFZUPiFS8N
         p7xw==
X-Gm-Message-State: AOJu0Ywovn/U4cJIjTcGVdlpgbdEQCQtaxFXQrQ+WdOyoRVuoNzW5MB3
        b30A3/btz0YWTW8vB0sX3g59rxpEHw+A6j6UwrwLWQ==
X-Google-Smtp-Source: AGHT+IFpDaUW/G+NIBQ7dLAwbA+C/QHfU3PbZe8rneNkbxpUCTxpmi5pN0JBoxEorR45o/FvaRPhEg==
X-Received: by 2002:a05:622a:15c8:b0:40f:ef6d:1a31 with SMTP id d8-20020a05622a15c800b0040fef6d1a31mr3251698qty.13.1691672382206;
        Thu, 10 Aug 2023 05:59:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id kf20-20020a05622a2a9400b003eabcc29132sm474314qtb.29.2023.08.10.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 05:59:41 -0700 (PDT)
Date:   Thu, 10 Aug 2023 08:59:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org, dsterba@suse.cz
Subject: Re: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Message-ID: <20230810125937.GA2621164@perftesting>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:30AM +0900, Naohiro Aota wrote:
> In the current implementation, block groups are activated at
> reservation time to ensure that all reserved bytes can be written to
> an active metadata block group. However, this approach has proven to
> be less efficient, as it activates block groups more frequently than
> necessary, putting pressure on the active zone resource and leading to
> potential issues such as early ENOSPC or hung_task.
> 
> Another drawback of the current method is that it hampers metadata
> over-commit, and necessitates additional flush operations and block
> group allocations, resulting in decreased overall performance.
> 
> Actually, we don't need so many active metadata block groups because
> there is only one sequential metadata write stream.
> 
> So, this series introduces a write-time activation of metadata and
> system block group. This involves reserving at least one active block
> group specifically for a metadata and system block group. When the
> write goes into a new block group, it should have allocated all the
> regions in the current active block group. So, we can wait for IOs to
> fill the space, and then switch to a new block group.
> 
> Switching to the write-time activation solves the above issue and will
> lead to better performance.
> 
> * Performance
> 
> There is a significant difference with a workload (buffered write without
> sync) because we re-enable metadata over-commit.
> 
> before the patch:  741.00 MB/sec
> after the patch:  1430.27 MB/sec (+ 93%)
> 
> * Organization
> 
> Patches 1-5 are preparation patches involves meta_write_pointer check.
> 
> Patches 6 and 7 are the main part of this series, implementing the
> write-time activation.
> 
> Patches 8-10 addresses code for reserve time activation: counting fresh
> block group as zone_unusable, activating a block group on allocation,
> and disabling metadata over-commit.
> 

Hey Naohiro,

This enabled me to turn on the zoned vm for the GitHub CI, we're only failing 7
tests now, so great job!

However all the !zoned vms panic immediately

https://paste.centos.org/view/54d11384

Can you fix that up?  Also you can submit a PR against the 'ci' branch of our
linux repo in the btrfs GitHub project to run through the CI yourself to make
sure you didn't mess anything up.  Thanks,

Josef
