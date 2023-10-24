Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823D67D5340
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbjJXNwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJXNvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 09:51:07 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2DE1709
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 06:48:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-777719639adso277599485a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698155309; x=1698760109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hQKcvJWyqotqDwpRk5uVqfEBmJ45eSGiDshV+vrsSQ=;
        b=wremb9jIHK0X+OT9BrT8hKXvPIfMAZ61uEvBBT6audQLSHDUIP1X7XPon4eHYhHytg
         d839iBYQJ2+5kDPHmS8k8D5A9dkW1VGDQeQZIXMki3mbDuOf/+tkFssz6BR25gLQ1CDs
         DwRpo/NxV9RcIuJigqWUK4ZLVOoCnaL42B6pmpjsVWI3iVgMwqa275SIpNP6zefkAawl
         TJLYKBCfb+wVMkLyqFq+1zaDEP6w2bE1IJKtGqHEtqQ3RRFNz9XkSMBdC046nNLM6ddF
         Un6hqA+wWY1rDl2wJceZk0r/RsaOsandTMp7TZ9YmG9sq0yTEYjbltqJ13p3+F0gttfj
         duTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155309; x=1698760109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hQKcvJWyqotqDwpRk5uVqfEBmJ45eSGiDshV+vrsSQ=;
        b=oUu8NAYzzffS4pjT2GK4qNIdo8MvjbUJub6CDO/i1GPH41a7JW7jAXWn5Q96EQvKoX
         m1c1ZMVxyJWPuZaGL5pvDDqiU5xZ/PuGHP9YkmL1AWI2uVoDYjsQv7x7NvaT4BXIcwYt
         /38KjCj00ZEUdXzLSIV1PAUOC0azw7fDTfSMAm6Z6Q51lxxq7xD4XIVETmL1tXmUXBg1
         shP5/pyNHe6z6D4X3UIbn3vLWAKSpC59fZkpuNzY++UqVs8wAhOE87BasixYOrBE12sH
         Tp88UCjgrbmce08KC02H4j/BCbiavSDDEYnnsuaFWzDYLSI+7NWlIvXgf6PULL8Wu9Iy
         en8Q==
X-Gm-Message-State: AOJu0YzD8nBRTP0uAWabcIIMV/Fhl91av20g/Unrw96ttnP7fP258Xe9
        QB/TpC7wBNlnyAr3BmcdXweXoIfrzaKw9YGWWuRh1A==
X-Google-Smtp-Source: AGHT+IFdgE6GgtL4JlDZHfI5TYgfStwcOsyReDeuQmo7GNN12CGwzQJ3DNiBB7dlULbVRB0J6zkH5w==
X-Received: by 2002:a05:620a:6848:b0:774:cd4:4a58 with SMTP id ru8-20020a05620a684800b007740cd44a58mr11058072qkn.39.1698155309639;
        Tue, 24 Oct 2023 06:48:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v8-20020a05620a122800b0076c96e571f3sm3453759qkj.26.2023.10.24.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:48:28 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:48:27 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231024134827.GA2811083@perftesting>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that ntfs2btrfs had a bug that it can lead to
> transaction abort and the filesystem flips to read-only.
> 
> [CAUSE]
> For inline backref items, kernel has a strict requirement for their
> ordered, they must follow the following rules:
> 
> - All btrfs_extent_inline_ref::type should be in an ascending order
> 
> - Within the same type, the items should follow a descending order by
>   their sequence number
> 
>   For EXTENT_DATA_REF type, the sequence number is result from
>   hash_extent_data_ref().
>   For other types, their sequence numbers are
>   btrfs_extent_inline_ref::offset.
> 
> Thus if there is any code not following above rules, the resulted
> inline backrefs can prevent the kernel to locate the needed inline
> backref and lead to transaction abort.
> 
> [FIX]
> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> ability to detect such problems.
> 
> For kernel, let's be more noisy and be more specific about the order, so
> that the next time kernel hits such problem we would reject it in the
> first place, without leading to transaction abort.
> 
> Link: https://github.com/kdave/btrfs-progs/pull/622
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Does fsck catch this?  If not can you update it so it does?  Thanks,

Josef
