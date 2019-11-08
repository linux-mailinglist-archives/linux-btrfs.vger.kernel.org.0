Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D00F57DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfKHTob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:44:31 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37888 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKHTob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:44:31 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so2680915qvs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=neVziem/uOoLRPCjfa3hSFj2VvZXyM97Kr1be1BRmQY=;
        b=HEOcbVkJckQb2IyLJdDhJYvZqORIDL1qY+Nk57uXv8+hnjQbxx/hsNzNUUdOPJ9EOk
         Li6ztI7fGJUTtwmb/Pyxg62mCx7tT9zWUjzxAPV+98c7RaBF/kSVT/3d2LKf1VyYG3aG
         VJfy1q9fYzPobnyY13AnPK7dUkewEBnN+j/5sQjaQJYbMEjQKV7/LOdDEEhkRYGBQKna
         lkwBw8UNF/OEVBQ5lYz2NUN5ftOVQ7zoE8MRkvvt7H/eHYQI4N+vHUbvgHeHppIp1tdQ
         61WCcKWVLfdH2ucJig6maDHfNNsevpkvnwaaTU43Q3jTn/MConOR/8UDhSJ3BBn83fhE
         NO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=neVziem/uOoLRPCjfa3hSFj2VvZXyM97Kr1be1BRmQY=;
        b=qVftgY4HAJb8BRGfVEz1xTGjehav3tfE/PWJshWwHY0VNMWdq2dVVZNPbiTzM9NAf9
         9B++Uqi7ke+rw1PCnplIAHbInAI24+qn5SBbCS8uoW5NuGkT8LGWyW0TgvlL+xzar8SI
         opktoTkByqPRAAy808bZrC1emrrBFkJBKLowBp8510lGMb3E6pU0RtQzUN3z0Ot+XmNq
         4XjtSTpvrYlJ/PYbVyObLVukRuPhPp44ertNrgITj2+XnaE6r0SGj95I+jl8sX+Xx4Ow
         EAqkF8boAZfXZ4ikEOQvzNngEYRMXgNoGpIyjNbRWZa92Ytbz1gFSoBtrQPNNoNTsOu9
         6tmw==
X-Gm-Message-State: APjAAAUtuQV7W7vyInWWuMpM7CCd/Ta/ExfhNozXF6ghFaFZozRYTPjN
        AEO71WzC024cQOyxVjzW1cxT/g==
X-Google-Smtp-Source: APXvYqwNHDGsLfzAID8cBRkMvvW38egTau/xu2Kce0Y0zdsOfH59QAszqFdgbxkQMcqksXeO3DH3pw==
X-Received: by 2002:ad4:4e2c:: with SMTP id dm12mr11363263qvb.195.1573242270438;
        Fri, 08 Nov 2019 11:44:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id y24sm3181935qki.104.2019.11.08.11.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:44:30 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:44:28 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 17/22] btrfs: have multiple discard lists
Message-ID: <20191108194428.il2fs4khcvg72uti@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <9affe695998972620340031ccc95caac909bfe4b.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9affe695998972620340031ccc95caac909bfe4b.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:11PM -0400, Dennis Zhou wrote:
> Non-block group destruction discarding currently only had a single list
> with no minimum discard length. This can lead to caravaning more
> meaningful discards behind a heavily fragmented block group.
> 
> This adds support for multiple lists with minimum discard lengths to
> prevent the caravan effect. We promote block groups back up when we
> exceed the BTRFS_ASYNC_DISCARD_MAX_FILTER size, currently we support
> only 2 lists with filters of 1MB and 32KB respectively.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
