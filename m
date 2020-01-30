Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6737914E467
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgA3VFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 16:05:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42858 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3VFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 16:05:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so4397020qke.9
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 13:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=K+spCnRwd+kyMKLekVAbDSwSITij7+iyRCfib6EBwHU=;
        b=MAsAAu9WnKROCE4w+M0GkBtwzMfoW//al5eJfVfmSXPl11W2b0XrPUqMpohdbwSCnz
         Wtu1rJ4EmvRfbHjko4nY01IkWwbs20D4+nO9m9jmVF2+D5NqA7+62TYGOAQ38xHlc2CF
         pp26Cn2s2q1qmgjs+DevSwqtgl2InH/A2kQ975ftsgw96cCVvikLj6flgBveIwYlx7xl
         llmqDfE4sJ2wB/r/T8oeqs7YEEDk+huCOdMzX+LVbU3ZXSm2/3WcdAwYyrgcCxMPSD8H
         VohrIVh+zjF6QqR+uqE6XDG5wruTghP/j+vU5ElibNsVXcLktSOteiFCRn1z+M1pcEdQ
         k0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+spCnRwd+kyMKLekVAbDSwSITij7+iyRCfib6EBwHU=;
        b=GaoWUFAyOmvE074JCQLIZIE4Ioa3sE7CShiKetJB9JajHCD3AsyPW2mld/e03dOQZZ
         mq/FDL7+XjYmKS8rLr21ZJyy4YLrgGLGeZ9Y37Jl13Q0qkJLeoXykvUmU/OKXXWUmRgQ
         CKnRYGOvgZq8o+pdgABflBC1PFmizBpjXnC370JZoi+YjDpl5NEzXYVHuKoCTZdydYBc
         +Y/dOcpwtUIGjk7q8blrf+2wiufVZyNmjmq6jyYOib10scLMSUXkL2dnK+WByWbfHrBU
         QKg1zYHR9S9Tcx3nKCYw2Dom9k6J95Z5Yey+yiL526gVMYMSIQKtEq3XaWmn43JAjtW6
         dIUw==
X-Gm-Message-State: APjAAAV/WF/Tzin7Bwh58havpMfcY6mEOG5OM5D4GqF90LHTgsUjx1i3
        G+IpXuwI9msYzFyX78WZXC0OBXFl8UgzcQ==
X-Google-Smtp-Source: APXvYqwWztdt1KbaNGjfI+4yssVIQTJK/FLRAlBvVio6i4K6b1QWXAylUpowO5cw61au+nSjyHOiiw==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr6835830qkd.284.1580418311567;
        Thu, 30 Jan 2020 13:05:11 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b22sm3330337qka.121.2020.01.30.13.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 13:05:10 -0800 (PST)
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
Date:   Thu, 30 Jan 2020 16:05:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200115034128.32889-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/14/20 10:41 PM, Qu Wenruo wrote:
> [BUG]
> When there are a lot of metadata space reserved, e.g. after balancing a
> data block with many extents, vanilla df would report 0 available space.
> 
> [CAUSE]
> btrfs_statfs() would report 0 available space if its metadata space is
> exhausted.
> And the calculation is based on currently reserved space vs on-disk
> available space, with a small headroom as buffer.
> When there is not enough headroom, btrfs_statfs() will report 0
> available space.
> 
> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
> reservations if we have pending tickets"), we allow btrfs to over commit
> metadata space, as long as we have enough space to allocate new metadata
> chunks.
> 
> This makes old calculation unreliable and report false 0 available space.
> 
> [FIX]
> Don't do such naive check anymore for btrfs_statfs().
> Also remove the comment about "0 available space when metadata is
> exhausted".
> 
> Please note that, this is a just a quick fix. There are still a lot of
> things to be improved.
> 
> Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have pending tickets")

This isn't the patch that broke it.  The patch that broke it is the patch that 
introduced this code in the first place.

And this isn't the proper fix either, because technically we have 0 available if 
we don't have enough space for our global reserve _and_ we don't have any 
unallocated space.  So for now the best "quick" fix would be to make the 
condition something like

if (!mixed && block-rsv->space_info->full &&
     total_free_meta - thresh < block_rsv->size)

Thanks,

Josef
