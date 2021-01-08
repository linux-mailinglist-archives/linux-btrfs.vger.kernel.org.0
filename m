Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030592EEB27
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 03:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbhAHB6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jan 2021 20:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbhAHB6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jan 2021 20:58:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA02C0612F4
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jan 2021 17:58:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so5301224pjl.0
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jan 2021 17:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGRQgQxhsyRXjQdwcCGlt2658u1jtlehbNwzYLBGfco=;
        b=aqqatEgF2oZhq7YnKo3Xi/apraNmUYuIG8cXbPC2iJ6MSU4SVCTf0ataJgGM3EkHv1
         qNN5igUMWfKXJ43rARqCmNRrWrqDIc1EIyr1K2cKL8SRBmBZzQhmlVNbeAq5E42gnYIh
         uNIiFe9NzXj3fgpT9MUCOeCTdJWBJaiPPzb0/XfUpT7pv4n846XugeOS4vLk1FCV17z+
         9BH5sGM2R9M5CWVvco9IZTdET66uaQ8KW1UJLAciqti39h39iFcdTqywhFAUG3XOSiGH
         tuuBbMDL1oTBUQShe+yqUXnrKemq9Z8tUqWZuN6F560NJRwd9zupjfWkuGHL50SrCK+K
         0BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGRQgQxhsyRXjQdwcCGlt2658u1jtlehbNwzYLBGfco=;
        b=UROxyZYKjtCR8zj8xbEA2Wd077qcML4k3qouQjgHzJRIncKubEjVYrH651+0eKgfrJ
         DCC3LzBIRFzYb9izEFdJCEwAxYU8G032d58X5jSqeL/moqj5ks/9L36I+B5rHGb+Q2IE
         23GxALTxII3y/N+n3bFQnWigRXgFyjuMYv6mmyiYhRFG8LFU+KptuejO2nvRfYCQ1ROL
         54LDgiY4lcO+oqnQiMnU3a33cweY56TkHBY6IbyCIumT19sJL/kr4glkUC08K3Y4TehS
         Bn650qAzwnWXPB/you+caeGCmABLTdoUaqIhu+cb3Ft3VtFreGskRUnac0QExsAnp2ak
         lMXQ==
X-Gm-Message-State: AOAM5314Zc0g0uOgtli2IYwg+CVnwQGpGZ/r2b4rbvzVHnix3HP0+Til
        1cIGFgPBL0Elit68IPlIQPmwP0DFvWs=
X-Google-Smtp-Source: ABdhPJz0YLwzwoJH+FOeWpAWVv8tJvPCSAYccTuehOAm/AbQ9rDUdgyUwk0M0+lhIY1yelk8EExsJw==
X-Received: by 2002:a17:902:9894:b029:da:5698:7f7b with SMTP id s20-20020a1709029894b02900da56987f7bmr1589552plp.78.1610071086732;
        Thu, 07 Jan 2021 17:58:06 -0800 (PST)
Received: from hosting.home (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id f7sm3135548pjs.25.2021.01.07.17.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:58:06 -0800 (PST)
Sender: Sheng Mao <ks8xntk9mds5i@gmail.com>
Date:   Thu, 7 Jan 2021 18:58:04 -0700
From:   Sheng Mao <shngmao@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: align btrfs receive buffer to enable fast
 CRC
Message-ID: <20210108015804.GA3423@hosting.home>
References: <20201226214606.49241-1-shngmao@gmail.com>
 <20210106121635.GR6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106121635.GR6430@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Alignment to cache line is a great idea. I guess compiler can issue
faster memcpy version.

Thank you!

On Wed, Jan 06, 2021 at 01:16:35PM +0100, David Sterba wrote:
> 
> On Sat, Dec 26, 2020 at 02:46:06PM -0700, shngmao@gmail.com wrote:
> > From: Sheng Mao <shngmao@gmail.com>
> > 
> > To use optimized CRC implemention, the input buffer must be
> > unsigned long aligned. btrfs receive calculates checksum based on
> > read_buf, including btrfs_cmd_header (with zero-ed CRC field)
> > and command content. GCC attribute is added to both struct
> > btrfs_send_stream and read_buf to make sure read_buf is allocated
> > with proper alignment.
> > 
> > Issue: #324
> 
> The issue has a lot of interesting debugging and performance information
> so I'd put something to the changelog as well.
> 
> The alignment fixup sounds correct, though I'd push it a bit further and
> move read_buf to the beginning of the structure and align the whole
> structure to 64 bytes, as this is the common cache line size. This could
> potentially help too with memcpy.
