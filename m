Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E513EF6F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 02:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhHRAjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 20:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhHRAjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 20:39:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718DFC061764
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 17:38:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l11so763577plk.6
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 17:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1vXyH7xyAEKWl9tjGLiS1fznM+0wOwkzN/18tVddcg=;
        b=BJLFreYxWx3R+jBFj8TD7FL4PfA+4YuPH0/kDR7aXzwc2xm54zRuUPk/BWoR6B9vPq
         RbhdNqrdNoAzKaSsZ04gLzoAEtWMV55LcPRnAfeMOQzn9oH3GdojRdkL5EnPRRzgO05d
         U+81FK+IvfmkkHXStAwesZAzyvP2ukR38ItDPpGx77mapQ10SNvuZoOnMq0+9he94ISs
         OUWyB9kj4r4SVaUMZiU46OaBQunjCpCn4FyAAiS1Zp+mn1bP5vJDTKAuUK5zFjmf+khw
         528MbEL6NBfFP5+wEnZ5koKLIZavfoHliSY3DQx50ms47d1FcIc5nxAgAxPSJCC68XPJ
         6zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1vXyH7xyAEKWl9tjGLiS1fznM+0wOwkzN/18tVddcg=;
        b=MfQuq6Q4oUxQ6io4y5fvnsL5hOezUNGJR8WnQ1I2IWx+WveB7/UKHKu3/eHdlUNda+
         v8gK8ncTmC+300XmUvSEazq3rL26W6hjv4Mn/3UcB2JQCxvVfaV9uLqreVWjPKgQeJiG
         /U2Ob55cpKLzTu1zeMs5YSiOgj9OO4Q78nT6wBt/4faed1z8jd9W3F3Up3gKOr1Kln2Y
         IUJlGBDGsW67drlThQx9KetjDDcWwF9l28Xnq4Vix7M96ElkZr92beAtS2ADR0eAaQNo
         VgP1ZFF6MXSy0Ml4ZHf0CBIIBzvy0YgYUWBX9+sz6p6j2kIOQu8sefoXI9CDpAb+BA04
         k3Ng==
X-Gm-Message-State: AOAM533iA2q1LnSQ4Difd7pmsoTxLyXaaobxuLTMnmTseZ8eBSdo+G6x
        ACH5eEOY0J5SjrnwGlFOSAc=
X-Google-Smtp-Source: ABdhPJxTZSwP5OuBCnrOrDvC1ggDdizVtOeXHJwJ00fLlXB9JTPHMWXTzdUUHfN4gVt66g2wv1Z4sw==
X-Received: by 2002:a17:90a:6303:: with SMTP id e3mr6423183pjj.190.1629247116739;
        Tue, 17 Aug 2021 17:38:36 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 11sm3586795pfl.41.2021.08.17.17.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:38:36 -0700 (PDT)
Date:   Wed, 18 Aug 2021 00:38:19 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210818003819.GA2365@realwakka>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817133022.GM5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
> On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
> > This patch adds an subcommand in inspect-internal. It dumps file extents of
> > the file that user provided. It helps to show the internal information
> > about file extents comprise the file.
> 
> Do you have an example of the output? That's the most interesting part.
> Thanks.

Thanks for reply.
This is an example of the output below.

# ./btrfs inspect-internal dump-file-extent /mnt/test1
type = regular, start = 2097152, len = 3227648, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
type = regular, start = 5324800, len = 16728064, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
type = regular, start = 22052864, len = 8486912, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
type = regular, start = 30572544, len = 36540416, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
type = regular, start = 67112960, len = 5299630080, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none

Thanks,
Sidong
