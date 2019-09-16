Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1CB42E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbfIPVU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 17:20:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35796 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfIPVU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 17:20:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so1580854qkf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=bksU6qnJjmCwMxnHVelpXjOY7cjbT2qxfJfQ5o++/Og=;
        b=GEPA2BOP80WgYu+VhQ2TSpL9OKq84+2+UTpSaQuMS8xtppemOOlC+e3OjEDHJ03vP9
         Zy/Fb7zpzSfHJSdeIe49kbb+h/9Dyx9iTaEpg6dz6KXp5qsapIjif/7EM1xHvFIOZfsE
         +L9m8NjOzfz91gZSHWLKDe0lik8QEmm574Dqs9iK6TFWSfjVJJ3+F9Csvux4O5UYFa3w
         ct+caOA5PHU689o84cZ7X2VS+SwLjn1+Anqwwe8spX3zX3MiSugC0UaLBpKeV1S251Vm
         vE0FrCzDgPD8+pDdguG85GyXEIFP9/0sUw7KK5yk/K7pJF3vL+xQ7x2v2QOY+drocHRW
         7biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bksU6qnJjmCwMxnHVelpXjOY7cjbT2qxfJfQ5o++/Og=;
        b=TlZmpRctQTaK78qacTysruxcuzLuU5O0SnGQB+WfVY07GyXlXvmzaGs3ahbqI2YHrU
         tDZgGC1iP8/e2LOiMCBS0CwWpu6PPlpxV63dqA6dornF02hAYJBDDhxq6lWplqZ3+HUG
         x5HY7faFXZ469+RW5hrmPI33FS/JeS9lHYJjISXOVQ6+labF+u649yeDYMoO67jPWjo6
         XaDxDRpD/Jaa9+N8xvhWCZ9asPrCy6+YdGK4dy9Sm4ss7SDxSwL35ErANBXgQeQTrUcu
         naoU8BeF0Xf62wQs8EHjXFy/jTK9/eYHZVaGY0CcNNfPNlZCWymoXLvL/mpg67UnQxYr
         6bJA==
X-Gm-Message-State: APjAAAUhN96yg0GTD7wCmBxYmRI683Vtx4zRaJjOyPW0K0Mq03OngNZ5
        iSJZ6OSH0CTr9xBrQSpyQsXdjOU+
X-Google-Smtp-Source: APXvYqwjcU7zfsd6aAIyTBFTEWDilsiGCcKV4778aJ7ZnpcZqbfwEloRb8thfNERko+rGCt4ozdXnQ==
X-Received: by 2002:a37:a503:: with SMTP id o3mr367626qke.115.1568668827021;
        Mon, 16 Sep 2019 14:20:27 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:b5f7:9f14:2fec:eee0? ([2604:6000:1014:c7c6:b5f7:9f14:2fec:eee0])
        by smtp.gmail.com with ESMTPSA id b4sm50813qkd.121.2019.09.16.14.20.26
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:20:26 -0700 (PDT)
Message-ID: <6476e5f02a4bdf26c8f342db11f6dc1675c94394.camel@gmail.com>
Subject: Re: while (1) in btrfs_relocate_block_group didn't end
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 16 Sep 2019 17:20:25 -0400
In-Reply-To: <ef805fda2976d3b89b80204f8d119a9342176bae.camel@gmail.com>
References: <ef805fda2976d3b89b80204f8d119a9342176bae.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2019-09-14 at 17:36 -0400, Cebtenzzre wrote:
> Hi,
> 
> I started a balance of one block group, and I saw this in dmesg:
> 
> BTRFS info (device sdi1): balance: start -dvrange=2236714319872..2236714319873
> BTRFS info (device sdi1): relocating block group 2236714319872 flags data|raid0
> BTRFS info (device sdi1): found 1 extents
> BTRFS info (device sdi1): found 1 extents
> BTRFS info (device sdi1): found 1 extents
> BTRFS info (device sdi1): found 1 extents
> BTRFS info (device sdi1): found 1 extents
> 
> It continued like that for a total of 754 lines until I rebooted. Before
> that, I captured some debug info. I ran this in my shell for a few
> seconds, where PID is the pid of the process that called the balance
> ioctl:
> 
> integer i=0; while true; do sudo cat /proc/PID/stack >stack$i; sleep .01010101; i+=1; done
> 
> Which effectively gave me stack samples at (close to) 99Hz. Maybe not
> ideal, but I was in a hurry and I didn't want my disks to sustain such
> heavy, repetitive I/O for too long.
> 
> I've attached the stack samples as stacks.tar.gz. A few of them are
> empty. To me, it looks like the kernel never left the while (1) loop in
> btrfs_relocate_block_group. The kernel messages seem to confirm this.
> 
> I am using Arch Linux with kernel version 5.2.14-arch2, and I specified
> "slub_debug=P,kmalloc-2k" in the kernel cmdline to detect and protect
> against a use-after-free that I found when I had KASAN enabled. Would
> that kernel parameter result in a silent retry if it hit the use-after-
> free?

Please disregard the quoted message. This behavior does appear to be a
result of using the slub_debug option instead of KASAN. It is not
directly caused by BTRFS.
-- 
Cebtenzzre <cebtenzzre@gmail.com>

