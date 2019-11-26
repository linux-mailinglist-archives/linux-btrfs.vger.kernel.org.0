Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1F10A390
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKZRuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 12:50:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37092 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKZRuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 12:50:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so8473472plb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 09:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=59Vgy8vcI52/DliuLIm2lvu2SIX3lTZeIDQ7bzNt55A=;
        b=2P86c4crOOWqvpSJVJ2SeRKrNeze8qhqQtkv34djNbIVTGgRMwwI8pLRCecox3XRUv
         9xDeyNtqO3Hsi5wL2+5aF5XBWgBlAQdjBsXg3P8cMnDRDRKPWzyOMHlnN8RCb06XOVJX
         JwwUa+yjSqSxur4anwq+ESdm2aFh/TY2fStmsP17N23n55lgodF7qnYbN2KAtFg79JL7
         8n7AG0dK5GuqBwjuYkFSBZnBlaigtqYe1fVgB5b26phYc7hoUGEDoM5h5p5ld03tRjQD
         VRksa6Fw/DnjFiy88YkxTfaBYc77F+LuZLdjkoD83sRj5w8aWWySrOAzL71YDCW1K26p
         ddKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=59Vgy8vcI52/DliuLIm2lvu2SIX3lTZeIDQ7bzNt55A=;
        b=chv+lx1mU1wpXLFixcLrvWkBzY4UnLbZ9OWu2cVJpm08KgygIENx+HQ74gj6Z8oUy+
         EY6lxvnpmcr7o7NNFGFpidTtQozwsjtqqpJsV+IyCL6cswU7NVg1YK7Yad0QHfiX6lJU
         eqteko6ldPwlZyZGCpzkvs2Z5qnfffCfTOuTEMRAYjl5vVReTr9Et9q++NlgEuFbRHZ6
         j5KQvOVGGEl1ueUKix1sVmRbuFeZku3dhFdEuuXccd3SpbY2JEW/x2RoNguW1bS//YDr
         yLsSzhzsyDccaSCuHA2yA6ax4PG/RgNTFX+b9tjitgyRruncHD5gryi36tqA7LhYICaa
         ZnrQ==
X-Gm-Message-State: APjAAAU1xqyVSdQ3vHrWnFDGJhDXgmwgqO5spopKgIEhnv8dDYNVmz0G
        HcdTh1lFowdUAq97M66nMJKvfn82ePI=
X-Google-Smtp-Source: APXvYqz+pZ81z29BEoNRF6pU6va0mwYVHg7ekqwOjyXpK7uAsydkEqLGGja3NjeTYfxyfO+YmTPbsA==
X-Received: by 2002:a17:902:8508:: with SMTP id bj8mr1477005plb.178.1574790620287;
        Tue, 26 Nov 2019 09:50:20 -0800 (PST)
Received: from vader ([2620:10d:c090:180::aa28])
        by smtp.gmail.com with ESMTPSA id 67sm3107387pfw.82.2019.11.26.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:50:19 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:50:15 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v3 05/12] btrfs: don't advance offset for compressed
 bios in btrfs_csum_one_bio()
Message-ID: <20191126175015.GA658856@vader>
References: <cover.1574273658.git.osandov@fb.com>
 <a669365a9165b18814c635f61ed566fdcd47a96f.1574273658.git.osandov@fb.com>
 <9669273e-5a73-540f-2091-5ce64e093062@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9669273e-5a73-540f-2091-5ce64e093062@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 04:18:45PM +0200, Nikolay Borisov wrote:
> 
> 
> On 20.11.19 г. 20:24 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > btrfs_csum_one_bio() loops over each sector in the bio while keeping a
> 
> 'sector' here is ambiguous it really loops over every fs block (which in
> btrfs is also known as sector). SO perhaps change the wording in the
> changelog but also in the function instead of nr_sectors perhahps it
> could be renamed to blockcount?

Fixed, thanks.
