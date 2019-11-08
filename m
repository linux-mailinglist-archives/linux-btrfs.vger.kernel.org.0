Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBEEF584C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKHUPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 15:15:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42965 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfKHUPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 15:15:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id t20so7851219qtn.9
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 12:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ahKEYAmk3MOxCrKBQIHmaUXyvSLHCoSr+L2KQf1u5C8=;
        b=Nbbg7IrL3PfzhyCGr0THB8yOIH5+j5ErbRYut9lt+xM29BvznklYOrU1wR++lTvfH2
         UI65Q0lQP4EHNAKJZ/ZkL6cz8E2vvHVPDDAkxV6h0X4kHtOnvVHHJnt275TrmAhqJII4
         k/rs1Id3ALxllkmdMbaQZfXh4owo2QwMZfZkiWg8F7ZqOIoN4Wvwivz+Rm1qcsuAhKhF
         geCUrfRSm/RfLz9y3aMUnicQPymoHmjSEjRCXSMnk7fr0/O1z5wzVRLSxSrNQk25VM8Y
         Hgecoyameec3tsBNkdjk++YKnVMiZiyAqXMXUBPmK2mbgLit/uGe9sSoyH4iHelU8lp6
         vieA==
X-Gm-Message-State: APjAAAXVs/12p2eSJaVAflDdRuwR8JKAPI68ZjgzsiDYwoFHO9n/2Thh
        ndO96C744hto2hz0PxP+eX8=
X-Google-Smtp-Source: APXvYqzXpUZicXBbL+sOnB7vk4A4a3tH6LQr/3hcNnhoq/ZevdXdxMyWwZCkeFIO/3BAH2+sCrQybg==
X-Received: by 2002:ac8:3168:: with SMTP id h37mr12390599qtb.311.1573244103426;
        Fri, 08 Nov 2019 12:15:03 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::1:ac97])
        by smtp.gmail.com with ESMTPSA id l62sm3508899qkc.9.2019.11.08.12.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:15:01 -0800 (PST)
Date:   Fri, 8 Nov 2019 15:14:58 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/22] btrfs: only keep track of data extents for async
 discard
Message-ID: <20191108201458.GA51086@dennisz-mbp>
References: <cover.1571865774.git.dennis@kernel.org>
 <28b5064229e24388600f6f776621c6443c3e92b7.1571865775.git.dennis@kernel.org>
 <20191108194650.tcr5gsfl6vrh7riu@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108194650.tcr5gsfl6vrh7riu@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 08, 2019 at 02:46:51PM -0500, Josef Bacik wrote:
> On Wed, Oct 23, 2019 at 06:53:12PM -0400, Dennis Zhou wrote:
> > As mentioned earlier, discarding data can be done either by issuing an
> > explicit discard or implicitly by reusing the LBA. Metadata chunks see
> > much more frequent reuse due to well it being metadata. So instead of
> > explicitly discarding metadata blocks, just leave them be and let the
> > latter implicit discarding be done for them.
> > 
> 
> Hmm now that I look at this, it seems like we won't even discard empty metadata
> block groups now, right?  Or am I missing something?  Thanks,
> 

Empty block groups go through btrfs_add_to_discard_unused_list() which
skips that check. So metadata blocks will be discarded here from
btrfs_discard_queue_work() which should be called from
__btrfs_add_free_space().

We should just skip discarding metadata blocks while they are being
used.

Thanks,
Dennis
