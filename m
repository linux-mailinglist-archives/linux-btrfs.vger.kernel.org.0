Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A180CFB324
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 16:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKMPEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 10:04:37 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35691 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfKMPEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 10:04:37 -0500
Received: by mail-qt1-f181.google.com with SMTP id n4so2917756qte.2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2019 07:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hADQK8IQ+zEy0cptgE2Ol16QW5PmJRiKo0EM/akHwpQ=;
        b=a6K/G77+8cAbi4LjYUdqdbkPIVYkL3chckDwP4nnSx9oADAfr2fqReN9M2fKlq4Aqt
         qI2QKbjUtm8IVVkEIPIdunJhkzYHKnqA+4rdyDRFD1EdyighJXFPVNzS1a7ozOiln16i
         po7qoL62RL5oC+tSAOwlSiytx0gPh/xdsMRE5jHDsSbPWcj+CocVQFhYMUvDVfrCi1Ob
         yVDIl9h9oa5MkujJfdtYL2GHa/PQsJFBEVJFxzEsaYpR9NgyiUF2QwWuEbqj1CIQlj/o
         sv5+ThqdXI6N7Vkj7BQd3X/Yg4hQIFUKFOoWno0dPsFHBNSV+vVuWPXD6ZlaGhsJgQZW
         rO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hADQK8IQ+zEy0cptgE2Ol16QW5PmJRiKo0EM/akHwpQ=;
        b=FZ6+MQ2Fn9HKN81/ujo0fLJDIK5UgqIobLiDUUT/PA5juyNAaM6hgnfgKgdui3+a0M
         eYXZWwF1harc+5squ8q1S1uPrJipABmy7rpDOFoUPHTHWtQToVZMId3EBA0rB04jRUfS
         yPNN00q0fo8jIYLAXg/U/8GdxZdPzVe6xNHXoPsddN9Pn3gd537RuWWCLtlxujtOvC7X
         OngnYQ+foDMOHs9mbyx1rNPpkFOzoTAUSvTmvNucVxrMRsWen6x2w2oMtn9kDl8fEmCn
         s8TS08HBDVS3WwwbDjrb5vDmi3t8d5EJOaYIlLPooQDFoq8k6TH2vmgoY8FTWIKfHB2Z
         8WBA==
X-Gm-Message-State: APjAAAVtsfChMVIlEuJp8p9kq+qIfkK0ForeIFPr1EODDVPdRxrPTYEC
        qYP5CW3e3h40QD1yBQGQdsbgqe9IGEs=
X-Google-Smtp-Source: APXvYqzcbCNLaVHlMFGGuYmgUimXKhhwJ1BVDvf0FGlZAwRkTo2tAlAKfdAY7N+ExqqqieDgfBuI0g==
X-Received: by 2002:ac8:304c:: with SMTP id g12mr2972879qte.358.1573657475704;
        Wed, 13 Nov 2019 07:04:35 -0800 (PST)
Received: from [192.168.255.200] (user-12l2ihc.cable.mindspring.com. [69.81.74.44])
        by smtp.gmail.com with ESMTPSA id x30sm1457693qtc.7.2019.11.13.07.04.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 07:04:35 -0800 (PST)
Subject: Re: btrfs based backup?
To:     linux-btrfs@vger.kernel.org
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <31007555-d254-b83d-ecd9-c3ccadb0df6e@gmail.com>
Date:   Wed, 13 Nov 2019 10:04:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-11-12 13:34, Ulli Horlacher wrote:
> 
> I need a new backup system for some servers. Destination is a RAID, not
> tapes.
> 
> So far I have used a self written shell script. 25 years old, over 1000
> lines of (HORRIBLE) code, no longer maintenable :-}
> 
> All backup software I know is either too primitive (e.g. no versioning) or
> very complex and needs a long time to master it.
> 
> My new idea is:
> 
> Set up a backup server with btrfs storage (with compress mount option),
> the clients do their backup with rsync over nfs.
> 
> For versioning I make btrfs snapshots.
> 
> 
> To have a secondary backup I will use btrfs send / receive,
> 
> 
> Any comments on this? Or better suggestions?
> 
> The backup software must be open source!
> 

Borg [1] backup on the clients. That will get you:

* Automatic 'versioning' without needing snapshots.
* Automatic compression and deduplication of the backups (without 
needing BTRFS to do either).
* Automatic encryption (if you want it).
* The ability to mount your backups like a filesystem (through FUSE).
* All in a layout that's reasonably friendly to copy between systems 
with tools like rsync or rclone.

Borg's big thing is that it does reference-counted deduplication of the 
individual blocks of the backup, so incrementals take up next to no 
space or time but still give you a full view of the backed up filesystem 
with each snapshot. It also has support for accessing a backup server 
over SSH, which is a bit more efficient than using something like NFS.

For the copy to the secondary backup, you could just use rsync to mirror 
the backups done with Borg (or alternatively, us rclone to mirror them 
offsite to cloud storage).

[1] https://borgbackup.readthedocs.io/en/stable/
