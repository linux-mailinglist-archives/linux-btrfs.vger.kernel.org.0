Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E150681A96
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 20:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbjA3TfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 14:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbjA3TfD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 14:35:03 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65613537
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 11:34:59 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id w15so9579700qvs.11
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 11:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2b137XnJBrS677f+XRxurpQjkaGU3c/CMHYJbFxwD3U=;
        b=dwo7D1aOqx1m5UlMH45bnAxL0st+tiT6nvkj/AWLiJx4By2fo1keG0hTICd2tEIN2o
         KS/k2JqL3Sa5f+51Jj/peGUo8c8TzSp/15XF2HQWN1qwGOubjEMSE9S0w7r/95XLqOLE
         aWIo1gzB1/zGvPhSj9OGDpaufnR6u39/NT6NjuNKZj2crB6PlcSvxnoK2zbnl5w6tH2M
         1ZwiNna/K/vJrDeE8+huJBey1hDdDJrGMLBZP3UO9jgrZJgu5HuiI5p3G3hCHfBTrGs/
         ZXNcjKg4+RPgK62uHMBhXPu8ZbEj6qNUvVbQCSxt60vGv7p3JEBM3Aag42mzEX5GaRkL
         do+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b137XnJBrS677f+XRxurpQjkaGU3c/CMHYJbFxwD3U=;
        b=kgkElyb0r71gdLz9rCjXECi/+Ue7Hj0/tMb9iykUYLURILhRxtgpL3hUPdd/K2nSVl
         5C95C/lKJFiW21LVK3UrYr60opi5V9+tWiL1n6fw4dl93fEu2qcd26UKPFHoepqosz7O
         5Z5dMpIVHDEFRkWRtB5sKZVywZMZWTd2B1/l6OyWGYT+E9j23VfFFQ1S+t/fXSqRtrhO
         ccFk5Ew9XnjPP8arZEExlpb1Y97lXJOcyLcUmmiDkFBHBBuEoqvGnmDueWX+I6EuPBQk
         4bClY2v77KDWGCI4MRTdXdL18UX1ue/E9uXQFymkT0iTeT7LeVHL3KiRJGjpPJr64qcJ
         /VOg==
X-Gm-Message-State: AO0yUKXcEm8XeSzdhVElj/lAeTvRtHEYH3InBByWCzzbsmI6Fxj89Q+V
        4/zlaeHjCBvJOS4z0xVXXBldqg==
X-Google-Smtp-Source: AK7set//azM2dxDDGOLXpVsbqrAxm2mucoXh3pstvzko35O7VfXh61eogGBUgWJKjrzvIf0bJt+uEw==
X-Received: by 2002:a0c:ca09:0:b0:53a:6e21:5f6c with SMTP id c9-20020a0cca09000000b0053a6e215f6cmr11429994qvk.32.1675107298848;
        Mon, 30 Jan 2023 11:34:58 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id n20-20020ae9c314000000b00708fd79fab7sm8600425qkg.101.2023.01.30.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:34:58 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:34:57 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.com
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Daan De Meyer <daandemeyer@fb.com>
Subject: Re: [PATCH] btrfs: free device in btrfs_close_devices for a single
 device filesystem
Message-ID: <Y9gb4eFlYh/b7XRx@localhost.localdomain>
References: <faf1de6f88707dbf0406ab85e094e72107b30637.1674221591.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf1de6f88707dbf0406ab85e094e72107b30637.1674221591.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 20, 2023 at 09:47:16PM +0800, Anand Jain wrote:
> We have this check to make sure we don't accidentally add older devices
> that may have disappeared and re-appeared with an older generation from
> being added to an fs_devices (such as a replace source device). This
> makes sense, we don't want stale disks in our file system. However for
> single disks this doesn't really make sense. I've seen this in testing,
> but I was provided a reproducer from a project that builds btrfs images
> on loopback devices. The loopback device gets cached with the new
> generation, and then if it is re-used to generate a new file system we'll
> fail to mount it because the new fs is "older" than what we have in cache.
> 
> Fix this by freeing the cache when closing the device for a single device
> filesystem. This will ensure that the mount command passed device path is
> scanned successfully during the next mount.
> 

Dave, I think I like this approach better actually, it may be less error prone
than my fix, if we just delete single disks from the device cache we can remount
whatever later.  This may be safer than what I suggested, what do you think?

Josef
