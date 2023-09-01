Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCB790283
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 21:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbjIAThM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIAThL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 15:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E710E4
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693596983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olB9rlzeCl18BkZB9HsbK4exgRDNJOMVbe8vy/cuDac=;
        b=EP9dwiP6GvA0C/S+fCaEUaAT5MvRDPncN3fiejbssGsGPMxbbvj+kWfe0oJaeJngsQ4Y2W
        V847otJ7f6onNBjZURyBo3paeYT5k7A2WKsA4RB872pinHO1OYZFvvynO1iaeZ1og5/Qow
        puC9BKM6D66BS6Wj772ICN1MD+1Jm0Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-m-wBK0PdOO-A8VExQSgw4w-1; Fri, 01 Sep 2023 15:36:18 -0400
X-MC-Unique: m-wBK0PdOO-A8VExQSgw4w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c09d82dfc7so26564595ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Sep 2023 12:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693596973; x=1694201773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olB9rlzeCl18BkZB9HsbK4exgRDNJOMVbe8vy/cuDac=;
        b=lgITHnA4sqJlHp8qHPyG2aeFOYIXz44gYX98kynRqdx41DPsIXxn3NpWT4d6WhKywt
         Pn/bPVJpHikuxsizA5tzBkZg6byf8hySs4JutqsuNnOILknuZcOIm/jkZ7wzt7pFQRfg
         WK39fYMuR+zuKGXPoL+vA+NLScSo3GDU5bozqFrCvvS6BxqZT6Su/K7m+pa+l8RU+1VT
         5avE4YHx6qE1+/e8CTGA1oxCSO4XzTImdZSUCiU7sPo59x+plcfnRCP2+TpRpSITMaZH
         V/WQ3ZaQaMPNg5VsJa77JT8cL1bqISSa3PJf4aMjJgNPl8uUhxzLzBdnfajD1m0hL1NE
         3+5g==
X-Gm-Message-State: AOJu0YyAqSg9GY9n2ExW3YyKjHV6OC9kbLwcSO9usCjnDU8Q8U/CCsmb
        uLBfyVLCAdaKdDxfkFMyFvF/8VcdzXEB+CdwZxk2ifgpGOgs011JwrcnmUuxEPhvkvb1hQNQ4KI
        LTMXrF5DIncj1rtqAiRWnqFs=
X-Received: by 2002:a17:902:c209:b0:1c0:d89e:9038 with SMTP id 9-20020a170902c20900b001c0d89e9038mr3341439pll.20.1693596973315;
        Fri, 01 Sep 2023 12:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECZTXyG2wQQDNne4XDTcR8++A+Hg9I+ZMv2maaq5F/8HlbS5tjgspq5QyMAa5Mo1fs79RgFA==
X-Received: by 2002:a17:902:c209:b0:1c0:d89e:9038 with SMTP id 9-20020a170902c20900b001c0d89e9038mr3341423pll.20.1693596972970;
        Fri, 01 Sep 2023 12:36:12 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001c0774d9327sm3326272plb.91.2023.09.01.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 12:36:12 -0700 (PDT)
Date:   Sat, 2 Sep 2023 03:36:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Message-ID: <20230901193609.yy7isx4pv6ax4g2k@zlang-mailbox>
References: <20230824234714.GA17900@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824234714.GA17900@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 04:47:14PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> I run fstests in a readonly container, and accidentally uninstalled the
> btrfsprogs package.  When I did, this test started faililng:
> 
> --- btrfs/282.out
> +++ btrfs/282.out.bad

I can't merge this patch, it fails:

  Applying: btrfs/282: skip test if /var/lib/btrfs isnt writable
  error: 282.out: does not exist in index
  Patch failed at 0001 btrfs/282: skip test if /var/lib/btrfs isnt writable
  ...

How can you generate this patch with btrfs/282.out.bad?

Thanks,
Zorro

> @@ -1,3 +1,7 @@
>  QA output created by 282
>  wrote 2147483648/2147483648 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> 
> Skip the test if /var/lib/btrfs isn't writable, or if /var/lib isn't
> writable, which means we cannot create /var/lib/btrfs.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/btrfs/282 |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> index 980262dcab..395e0626da 100755
> --- a/tests/btrfs/282
> +++ b/tests/btrfs/282
> @@ -19,6 +19,13 @@ _wants_kernel_commit eb3b50536642 \
>  # We want at least 5G for the scratch device.
>  _require_scratch_size $(( 5 * 1024 * 1024))
>  
> +# Make sure we can create scrub progress data file
> +if [ -e /var/lib/btrfs ]; then
> +	test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
> +else
> +	test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
> +fi
> +
>  _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount
>  
> 

