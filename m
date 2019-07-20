Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 904036EDE1
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 07:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGTFmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 01:42:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfGTFmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 01:42:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so15059900pfn.5
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bimwqln4w8X0dypwvXkRtc71evwVEVYYolYvzvfh34s=;
        b=yaj+LIMMgUBtzRxsCnggkvmykmD3bcKVePt8tcKRMGktBEHWKFpTpKnXMerbD74W7W
         0QoeOp/PRHk4qSXeD5XhN0JrBZEnHDqmyqL57F6eT/FKnhxoKEbjs+ZT7MwStoMG4H21
         /mqkYt3omHQpAhfUAvr6lB1+C8YKSd/6L78Iam7gxffFYVCoKT+u/9LegMfZ4ssLwTw9
         D5k5d/VhTgc0ztCeYUp/9S6Rpe3fEzWGEUWRAB2BjH+Mq2b5xmNkjLfDkKAr2BMgIRY5
         jmpRXmg6izkDLFaUzGvhZS/JMFtzRRy2s9uaCHBB3Zp5JwcLsrGodr1ni+Z/SpeAQiK3
         Rz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bimwqln4w8X0dypwvXkRtc71evwVEVYYolYvzvfh34s=;
        b=WVZBUDC8UGWn6EUfASdSLN7zpgRTyOKo1yU2DjHz63vaPaSqilL7LtRv8Z03cLUU6a
         adOOhHe4PwtEkYus/P4px0cmh2XMTPoCtphaYpRLQeKVrmFKG8gSSSJiZFVJVmcyeYTi
         JAcXOey60QLhiSoVJ8nUZy85Njj3hVOH8RIG1E0PxGC4iA7DZ991pY/i1WUZcp0rUPY7
         KzX9L/wzJXGByGwSFKtc0FReEFuTcBDiRJ4uii/QddbVeHpnmVsN8t+c9RhnSY/f9Zzy
         VFihpdmUPUvocS7XpNeNYajZExTzC7TxQuydB7t0GKKgBuRrYt/ikcm/84g/c9xjpAmE
         oc/Q==
X-Gm-Message-State: APjAAAUNWrZ2dYKI8K9IXPa7LFU9YBJrmc+4DAMgOTuf9PdtZuztomS3
        QMod+sSxWgp4L4Bz8xe/pSb7xwX6ZCk=
X-Google-Smtp-Source: APXvYqwCpk39BWYVw0iW7NEKnAdQcnGYmu/FYHPm8NR8gOn10wmT2FH8deHaIOGfCly3KoBY1x7hPQ==
X-Received: by 2002:a17:90a:8a91:: with SMTP id x17mr62507095pjn.95.1563601362119;
        Fri, 19 Jul 2019 22:42:42 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:ba1e])
        by smtp.gmail.com with ESMTPSA id v63sm33831774pfv.174.2019.07.19.22.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 22:42:41 -0700 (PDT)
Date:   Fri, 19 Jul 2019 22:42:40 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs-progs: receive: get rid of unnecessary strdup()
Message-ID: <20190720054240.GA7638@vader>
References: <cover.1563600688.git.osandov@fb.com>
 <f0142166d2059ed0bf319778dd3146d1d0b4523d.1563600688.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0142166d2059ed0bf319778dd3146d1d0b4523d.1563600688.git.osandov@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 19, 2019 at 10:40:00PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In process_clone(), we're not checking the return value of strdup().
> But, there's no reason to strdup() in the first place: we just pass the
> path into path_cat_out(). Get rid of the strdup().
> 
> Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> Signed-off-by: Omar Sandoval <osandov@osandov.com>

Wrong SOB on this one, should be the usual

Signed-off-by: Omar Sandoval <osandov@fb.com>
