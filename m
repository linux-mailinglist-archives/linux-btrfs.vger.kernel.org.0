Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F064F57E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfKHTqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:46:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38617 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfKHTqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:46:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id e2so6346233qkn.5
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYXF1Cpiixr536VkZK5euZoq91PNP2zsb/PvkBwsNT0=;
        b=xFgfJ2fKofA3XnsO2BfkfPLkkeAUiEiIWPWjzMkTPNNY0JuNFPkRpd9C05DGldX4YB
         Vw8I889Lj3PbFDSD5e/9+ZWb63/A8SScwimtdIst4zur0eSEfyz1WbIm4Dt/YmSy9TZo
         NgsVnM/uNSnHnpKx3yFFcTmb+orde91eDU2AwnPhesTdmFVM5S7UpRw336kKHVki6Pb8
         DZpHfpF1FxHycWtRT2G0ojf7oF9MUxTVXcOUvNC4KyFAZILYyvOTJwyki/oac2ZO10xe
         EZVeQ8AKYyQV/A7H2MAZ3RbJ4mR7K9uwXR3xzoqyYC8qt6bSYE4JGulJRvWEGu6csJhA
         ZS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYXF1Cpiixr536VkZK5euZoq91PNP2zsb/PvkBwsNT0=;
        b=XWSKnpietRKDnEOzRDbHZ8K3Y3m6pUErPzbYZynJtT3V7OQ/vNUFxZaKdQmCh5IMFD
         zEJqKVT6+BCqcGIsgQJqJK5V50qGUnKy50al47bRgERKmCPJ6LfqHPnOKhMOCp77uX9G
         qhXSISOom3GQwjt9suBSpixVcJ7U67lYQhddZLELL5kUe/A/EKQF0enX0wHM60DuMfbl
         cZS4ipIn0UIb2EpE3nuGOo+FWxQDNFkEW4DDWngPMbMvBgBwZ1UlIa/fkLz3mfL4asLg
         KnTfQLIHFFG5gFsIoOr6N3D1IuEirnXwDAaUNbZRYK6yIIG/dkUingfsy4GcyFsQhNWq
         rjsg==
X-Gm-Message-State: APjAAAWZFgXcekOO2ndk4eWviSjuRFqdAbO2SwO1qB22a9lBSeomaSS9
        0twCCsxYdW9y+aMqnt/ODXkHog==
X-Google-Smtp-Source: APXvYqysMLBvej9e3IBSjEit648BeSeCF/XYmcS1sGUHK7t22BdF3RfQacJUvvNnlStVBo4/vbsI4Q==
X-Received: by 2002:a37:b14:: with SMTP id 20mr7507214qkl.1.1573242413241;
        Fri, 08 Nov 2019 11:46:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id k29sm2871285qtu.70.2019.11.08.11.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:46:52 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:46:51 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/22] btrfs: only keep track of data extents for async
 discard
Message-ID: <20191108194650.tcr5gsfl6vrh7riu@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <28b5064229e24388600f6f776621c6443c3e92b7.1571865775.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b5064229e24388600f6f776621c6443c3e92b7.1571865775.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:12PM -0400, Dennis Zhou wrote:
> As mentioned earlier, discarding data can be done either by issuing an
> explicit discard or implicitly by reusing the LBA. Metadata chunks see
> much more frequent reuse due to well it being metadata. So instead of
> explicitly discarding metadata blocks, just leave them be and let the
> latter implicit discarding be done for them.
> 

Hmm now that I look at this, it seems like we won't even discard empty metadata
block groups now, right?  Or am I missing something?  Thanks,

Josef
