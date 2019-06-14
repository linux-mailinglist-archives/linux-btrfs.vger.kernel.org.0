Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D246044
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfFNOMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 10:12:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37711 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfFNOMm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 10:12:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so2606268qtk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rAC+Hn22cr49ahogcik0pcBGLagZS3dETf2Wz5S13B0=;
        b=LFa2rt4qfms1O2bBvZEW+0W+yIcox6qSOOVAvbDzHmHWo7eTBXlpUAexcKk/hD3cG+
         rZ0+KCTtWiy5i11ac0ffORaj13AQegx+B3gE4nQ1qjDlsSxGZxe41ifQWeW/cRdygt3S
         z4xcC/+/F/ZBom7OzAh9BRsonM/Aaa18VswtLxMXOOaLL32rLfu84gAbFeINiulLvMLR
         Yq/ZKonKABWtRk2lRehY3/uysF7DQdtvGRU569vLLFCcMz9mMuy9x3Q3seIf0ssPYt7g
         O6W0+KYhEf2U1P2W64QDZzS7jPc3N1x7t1sOs4846SUMiyw55JhL5l5bqMy50hkQYXYM
         jJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rAC+Hn22cr49ahogcik0pcBGLagZS3dETf2Wz5S13B0=;
        b=GOxfw5jQbxhH+v6O0UXKLvCTn8UcqhU87gWE4fXFS4bdQ4nkqTk2pS4IZ8vXx2TY/x
         1D9Hh1Bp/+wK1aFT+MbM3ZaVkulAaVaWJV/7x+97QA47UmGc9ydlyGeNIABFaYRoipqc
         DGflxL/aO6hqao/ABbkVyUcdKOXOjDkCl7XI0OjkzIxedjU8BGRGakufOg2Nr3fcJqZy
         l8Gkz703wAh0AKNBUmZGOkCUDqOFXuSlrrpeciU4PakgJEuE9tpiKoJcJiMdMYAyXXq3
         kP2v00yljSEiIDprKHsbzsK34L2atCwd65BM4t5j/yUhnB/ZIPXYbVm/rh/j1kXjB3xH
         DDZQ==
X-Gm-Message-State: APjAAAWfF7nDeaO/EiX4GfJd+j/iVDyQTaWSe6xs9LJAH2fEo2IDoA+l
        kiTvRsVOE05dFpDeWEauaZMArw==
X-Google-Smtp-Source: APXvYqyL0VPrGh6qcGTBP90vhD+R/W+sNmhvThLYHkzunbpAtLQ6J+jYlOSU6Vg8VPbSr9kS5SES5g==
X-Received: by 2002:a0c:d4b4:: with SMTP id u49mr8632899qvh.202.1560521561034;
        Fri, 14 Jun 2019 07:12:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id j9sm1394411qkg.30.2019.06.14.07.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:12:40 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:12:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/8] Btrfs: extent_write_locked_range() should attach
 inode->i_wb
Message-ID: <20190614141238.qhb45oehk6gbftja@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-9-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:50PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> extent_write_locked_range() is used when we're falling back to buffered
> IO from inside of compression.  It allocates its own wbc and should
> associate it with the inode's i_wb to make sure the IO goes down from
> the correct cgroup.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
