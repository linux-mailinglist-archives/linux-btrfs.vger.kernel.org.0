Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0EF9A3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLUGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 15:06:08 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37845 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLUGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 15:06:07 -0500
Received: by mail-wm1-f49.google.com with SMTP id b17so4335123wmj.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AaTTymFs++vqFdDBkUmUTK/5EmLmFuH5rql1MFbXnY0=;
        b=mw58T60GUzCDwIKllszauhBvkJ/DqwRzbRjQLBj28GPF5yyDl0deuc5QuLlk/4XG0r
         SQQ0P79FVe5HB8UXPnNorM6OLWnCkuInZ+4LPIYXfDJSu75XFtbmGtFZ1XS+hTk1baTp
         eazDiZ69YXLLFq4UYc4E+LYHJsp3GIiVOj5+sQ3Txqmdo/4734Q73/2j9+7qTTDw49W2
         2p3UeFxvUlkUZ+/2MaMp87ALhQYCOpv1fs9XEd8qnMXvC+8ipaQQFUDpZvuPMeBi4kCn
         q7gLz/UjM007oYxdQgubXV4TyH4Q3CrHfXxa33TmQcj/yTVom8eLmtZ5+MDSuc/jfJjm
         UVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaTTymFs++vqFdDBkUmUTK/5EmLmFuH5rql1MFbXnY0=;
        b=AyM7PXBqoVRXi4/EdxyejeQVVMgW9MSDmUHRGVyxAZE5V9Sgex3+vNde1hfgk10MOu
         w6y97vQcjnXPFVBMyqOwFUWs0C+V0fHguWpyKfJKTTOaDDyADvbGZdGO6SXgepQChjGG
         5XQq2ryOecaI6P5/ySl67LtIow7Q5k7vyDXhrJADR0bFqiXfxIj+0gO1X2cMnS+m+To3
         dSD7+2OPKUwQ/CkzLFnybVoYCBUx/mi44BCMqDCqefbkflkrK4uIluBVJ6g1e9ZnFsW7
         crl10Z88f7vorM5Ky4O4Rl/TPu0etkwyTka6b5tfvDVnvOIq4FwsD0Q16Nei+4zLzDax
         nwBg==
X-Gm-Message-State: APjAAAV1JqqiX4Sis/NHt3eJHFSGeHZZOibXlSvmXDEf/+YKSlzDCEFx
        Ti8gpzT9MqhOAZKoTwimrEdaYVVR
X-Google-Smtp-Source: APXvYqxCzmKRn1q5QeE6x4PLW1YByp/pUBae+eOs/U0cPVNt7PNKbz8LcOjt3bPdY7sR+jV/4lip9A==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr5976011wml.174.1573589163867;
        Tue, 12 Nov 2019 12:06:03 -0800 (PST)
Received: from ?IPv6:2a02:6d40:2b83:7000:fa16:54ff:fe84:9770? ([2a02:6d40:2b83:7000:fa16:54ff:fe84:9770])
        by smtp.googlemail.com with ESMTPSA id j11sm20432965wrq.26.2019.11.12.12.05.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 12:06:03 -0800 (PST)
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject: Re: btrfs based backup?
To:     linux-btrfs@vger.kernel.org
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
Date:   Tue, 12 Nov 2019 21:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm not sure if the btrfs list is the correct place for a generic answer - but I'll try to give one
mentioning all the backup solutions I have collected experience with (all open source, of course). 

1) btrbk ( https://github.com/digint/btrbk )
   I use it on all my personal machines, both for local snapshotting (to unroll my own mistakes easily...) and for sending the incrementals
   to an external storage. It's basically a well-working btrfs send / receive automation, so it needs btrfs at both ends (or becomes less efficient), which may not match your use case. 

2) Borg Backup ( https://borgbackup.readthedocs.io/en/stable/ )
   I use this whenever I do not have btrfs at one / both ends. It can also do encryption, compression and deduplication, purge old incrementals without ever doing a full backup,
   you can even mount your backups. 
   I use this for some smaller machines (e.g. on a Raspberry Pi) and we use it on our infrastructure for some configuration backups. 

3) Restic ( https://restic.readthedocs.io/en/latest/ )
   Restic is (feature-wise) like borg (but no compression yet). The main difference is that it can (but does not have to) back up to cloud-like storages such as S3. 
   We intend to use this heavily to a local Ceph storage system with 3x replication offering S3/Swift via Rados Gateway nodes. 
   If you want something less heavy than a Ceph cluster (we love it, it does not bite!) you can try minio ( https://min.io/ ). I never used minio myself,
   but only heard good things about it. 

4) Duplicati ( https://www.duplicati.com/ )
   Like Borg / Restic (can also talk S3 if wanted, or store to a file system, also does compression). 
   The main advantage here is that it has a GUI. Probably not interesting for your use case, but we intend to recommend that to our users
   with Windows / MacOS X who may prefer some buttons to click. 

5) Since you mention VMs in your signature, I'll also mention:
   https://benji-backup.me/
   http://backy2.com/
   https://bitbucket.org/flyingcircus/backy
   I'll personally recommend benji here, due to a large featureset, very active development and high efficiency. 
   It does differential backups of RBD volumes, so it will only be really useful to you if you use Ceph RBD
   (you can also get it to work with LVM and raw block devices, I think). 
   You can find some of our experiences with it here:
   https://indico.cern.ch/event/765214/contributions/3517132/

I think all of these are not too complex (of course, they only work well if your infrastructure matches them)
since you can essentially arrive at a working backup and restore in a few minutes. 
I'll also add that for almost all of our servers, we do not do any backups at all - file servers and services with data have their storage replicated to their HA partner node(s),
and all configuration is "backed up" by having it completely in Foreman / Puppet, so a machine can be reinstalled at the push of a button. 

The main functionalities you give up with your original idea (rsync to one replicated node) is that you do not have deduplication built-in and would need to do encryption at the source yourself if needed. 
Also, you would have to do regular "full" backups and think about how you can keep incrementals - rsnapshot (which nowadays seems rather dead) could do something similar via rsync with hardlinks,
but that meant you had tons of files which no FS really likes, and would always have to store a full file if a single byte changed. 

Cheers and hope that helps,
	Oliver

Am 12.11.19 um 19:34 schrieb Ulli Horlacher:
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


