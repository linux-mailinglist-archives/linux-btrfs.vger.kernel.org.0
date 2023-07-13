Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403F7752B86
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGMUTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGMUTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:19:38 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BA2123
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:19:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so1098562276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689279577; x=1691871577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0c1yLwHLFwR4uW/rxrbuLrvsAAbujad7TZCp+G5gk0=;
        b=AHJb00pIsYdIU/YTMc+KJEukh4Z+yAKTk1Lq+nFpjsKV4uQ+d51Gqzg2azrxbJ3HDE
         blslo3EsEwDDLqD7yUj/LQbM9ArwpjLYK+Q0b+z62aUJFpCXtMw2zLx4qHqpaow/HSD3
         xYBawF6QiRKwdSv+IpqVg/vrJyxXp2bywM5m5JOlQ1O/Ryuc1ijLzFaCphaGM4xjg+Ld
         cIM1PbqujTBVecWWioPJHzLXbX1BYdIgWlYwkGZNDHQHswHQxVk90bN2s/GnT9z0j2F3
         k3N3zq595mOLlThYSQh8vmIh8/J2L4D/Tv5M5TnPAKGO8In2Mx/m8IpgunwcBfQdUuB/
         aHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279577; x=1691871577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0c1yLwHLFwR4uW/rxrbuLrvsAAbujad7TZCp+G5gk0=;
        b=Z6/KMLkt4VHYfcV51Zx309Jx5EUevp0gEKD6ezDIF+5FoDE3Hf3EAPoTq3pZgESxg1
         ny60Q/csZjnh16ZAoen75NqE1BUdmrGpMkhG67f1dmCuvAj455WWvmpP6L4L1GkG7cWM
         n7HQvxKypY1WQF9axDxtGejdkVdiiYIGTUQnAfNOftQTa9K8DzzZIqtE6dUqxq6amaFs
         HmbMM2aw3zWoMDQIWlE70JNaQfAYInzDM8YGxKlt1XMvjFIYgBYbPzrn0iXnQcuBBaT/
         +pu7438IuLNc3E7sZF2Yezlt4lPMn+F+SQcosoRk834VgDjaqMUEgXQKAk6SMDKkunaf
         Cosw==
X-Gm-Message-State: ABy/qLZDi1kfe3v7G4/2ZiPX3x86xe2ti7Ikp97WOk7OdIZ3vS/ydfy5
        dn8+J1FeHBbO4VfS1OQSgjcP8w==
X-Google-Smtp-Source: APBJJlENnhOz9xJttejait0ELACeXdmcuXrfcn4qy4Q8Pb6hKjIcybEvR6omcl4ZaUYlL/Zkkuf3UQ==
X-Received: by 2002:a25:230d:0:b0:c6a:55e7:5b3f with SMTP id j13-20020a25230d000000b00c6a55e75b3fmr2560440ybj.52.1689279576914;
        Thu, 13 Jul 2023 13:19:36 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w9-20020a5b08c9000000b00ca519aa8cf7sm851552ybq.39.2023.07.13.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:19:36 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:19:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/8] btrfs-progs: simple quotas kernel definitions
Message-ID: <20230713201935.GT207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <d0a83da0b9f182e080fc693512d35f3476ab4395.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a83da0b9f182e080fc693512d35f3476ab4395.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:21PM -0700, Boris Burkov wrote:
> Copy over structs, accessors, and constants for simple quotas
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
