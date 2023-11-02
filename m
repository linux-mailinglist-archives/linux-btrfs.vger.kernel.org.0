Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB07DFB9A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjKBUgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKBUgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:36:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A0138
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:36:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778a6c440faso73797485a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698957402; x=1699562202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPZK6xyQRJzcZdyB317eb4Hg1Vna7OLoHS8NtN+RA3M=;
        b=Qf7KNv+hSo7RF2+AIhVC6iyb8W/DXWWMNvz72BVSDG7iFlEQGPwapIof6osHoUv3z1
         SMG1t+oY9pIswwRzXnOcoUvftMJmiDGvi2STuFZx2rmMdk0AEiOGl9sIbeHptYlQk8HT
         WGCmezockWkeEzADKo+Drd8phqAJlQDyIGPBE8vlNijD1f+ESR+VJmFQr5E9OW0fLeMi
         zoeLnhpuMDlqQVTT4cz5rCLgY1rpwNU+JNKun+8VpfE93oDH0NTqkxw2DhAOBuuagjJX
         PedTPA0BRIx1bQFlGQC7/qbjhIGyyT1PFkv71SM8CyuVZzpeOkpqogZ4LN98qQhhUhT7
         OWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957402; x=1699562202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPZK6xyQRJzcZdyB317eb4Hg1Vna7OLoHS8NtN+RA3M=;
        b=PvqN2wimkb/viZQvvuPkIIX9DgrZtLKXMvRb/SmsBkkWbh3hHEGjhdfbP8cKxYsg68
         bBeEZViinXwhvbA7QseySmJzjLiJVdC6ANkqDnIONG7Q4SHyZKE4B6slRs4PPlQtN/gs
         TMOIYNbOL+5SR2C99nx5BUdeOEfb89b6sQGl3HzAUFsvp2hQqga43h0VtIRWK0R6cDzR
         lbG2vYmddQPTM61gxtssqUTw/4zZCbacDCwsFIr3+7Ed16QFi6mfO7WVS2nWGBAimbLi
         10uvU26c2BFXUQm0eo/0kA5jmknvJ4NqgdH8HqnbGOg+vCGNVCeZCWmIFiOpIUtXhL+j
         lZCQ==
X-Gm-Message-State: AOJu0Yy5fq4UrKfPBpP5iaecFbXvbs9oLe9VjXcgZTbcWsN45r5FhLkj
        +0aoec6btRF5m1414jOYkC1Xy4ZI7Fozxez17stA4g==
X-Google-Smtp-Source: AGHT+IFLd6qS3OlVpmJx+S484YlrKrAhWb52IK87nKKmWk0IOXteD/4dVxm6C3iUeD6RwcOlri7brw==
X-Received: by 2002:a05:620a:400b:b0:77a:3f9:ee22 with SMTP id h11-20020a05620a400b00b0077a03f9ee22mr22198480qko.4.1698957401770;
        Thu, 02 Nov 2023 13:36:41 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a14a400b0076f35d17d06sm96001qkj.69.2023.11.02.13.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:36:41 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:36:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231102203640.GB3465621@perftesting>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This broke squotas and I didn't notice it until I was running the CI for my
mount api changes.

Lets try to use the CI for most things, even if you send it at the same time you
submit a job, it'll keep this sort of thing from happening.  Thanks,

Josef
