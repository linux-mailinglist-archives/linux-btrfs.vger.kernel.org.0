Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6271320641
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 17:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBTQnZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 11:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBTQnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 11:43:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C887C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 08:42:44 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b145so3919356pfb.4
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 08:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KzHY6/4Z867k87YZMo91aM6SOmQJttKzsxjxS0MI9SE=;
        b=HSfjvOsv6AGBLs0Hjty3LTXJfIIp8Li2bU7LSaTY/xQe6G8AJIKtG3+LcwsS4I6MiF
         Dd4y5pBAplqRmz0Y4JGHIGyn96k0OOvUnCQ//FfJTKm2ouXC0bBSfiKuXXcjbMPmaXGx
         hUGMB++vbzdhiIhg76CklysST2L0RjXoDWZcTM9rU2Nj/xxW2MwomfMRnXmenEIKbilH
         K8VB2oxiPh4vPclrUpcmv25stb6OncUE3G3slDNeeyuE39tq5LikdR5orRRDdnpyagrR
         fVfmWH1kr9GjeEN4WISuk3xpZWlK4MDvsUR7+RSKpx6j4O2jhnJCwcyemoAvenF0IhWU
         s30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KzHY6/4Z867k87YZMo91aM6SOmQJttKzsxjxS0MI9SE=;
        b=UsSELkCTlH4WXgMHgAVXV5HrHRKhosRQtyd19W8QFdn1Xn3ZFZzIerW0fgORYQgMkb
         IcSgFVm1DzyFKsdTsf9HnVanLEB9oG12qPdK9uZXuVVkFhN56vW6a/tK+BHEGNj7eywG
         UKSeaIP/cH4z3ACx1y9ODe2/mfzx46JsG/bCOSFR8OWifcr4gLwdlKTwjMaaWwi1JZ89
         zi40U/LLAQC0+atjrPg9429tcEtlR+omdOywjKGfuYohgu+TU3BHnUxNQoHngR18icVF
         M+8jhpaZKxd8ScOA/nSAfe8IoWGQzwgaoxtd/HsK5CuNDS3Vpym8bgMYqlGAuU/WMAwb
         H2Hg==
X-Gm-Message-State: AOAM532DNC194GrY1+X5tDsbrHdkx2zOdSPrlmFli4zK5UmTbQqIqdtl
        3q2lKzP8TE89JDYethZdMH4=
X-Google-Smtp-Source: ABdhPJz8Y2rYbOqiHxGGunJVLl0hlywQ4tSWKNjTOcXlSj1qKuDiSu04VLGXRlx7+vorZnHl1P1HCQ==
X-Received: by 2002:a62:5a45:0:b029:1e5:4c81:c59 with SMTP id o66-20020a625a450000b02901e54c810c59mr14709985pfb.51.1613839362987;
        Sat, 20 Feb 2021 08:42:42 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id k128sm13824853pfd.137.2021.02.20.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 08:42:42 -0800 (PST)
Date:   Sat, 20 Feb 2021 16:42:38 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RFC] btrfs-progs: format-output: remove newline in fmt_end text
 mode
Message-ID: <20210220164238.GB11258@realwakka>
References: <20210216162840.167845-1-realwakka@gmail.com>
 <20210219215611.GM1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219215611.GM1993@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 10:56:11PM +0100, David Sterba wrote:
> On Tue, Feb 16, 2021 at 04:28:40PM +0000, Sidong Yang wrote:
> > Remove a code that inserting new line in fmt_end() for text mode.
> > Old code made a failure in fstest btrfs/006.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > Hi, I've just read mail that Filipe written that some failure about fstest.
> > I'm worried about this patch makes other problem. So make it RFC. Thanks.
> 
> I found the discussion under the device stats patch adding json, the
> added line was known and "hopefully not causing problems", but the
> fstests seem to notice.
> 
> I think we can fix that by removing the fmt_end newline but we also need
> to update how the fmt_print is done for the text output. Ie. for json
> there are some strict rules for line continuations  (",") but for the
> textual output, each line ended by "\n" right away, without delaying
> that to the next fmt_* call should work.

You mean that if this patch applied and the code prints device stats for
text format manually replaced to fmt_print(), there is no last new line
for text output? fmt_print() prints new line before print some value now.
I think that it should prints new line at the end of each fmt_print().
like below

diff --git a/common/format-output.c b/common/format-output.c
index f5b12548..9a9f5bf7 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -242,7 +239,6 @@ void fmt_print(struct format_ctx *fctx, const char* key, ...)
                const bool print_colon = row->out_text[0];
                int len;
 
-               putchar('\n');
                fmt_indent1(fctx->indent);
                len = strlen(row->out_text);
 
@@ -312,6 +308,8 @@ void fmt_print(struct format_ctx *fctx, const char* key, ...)
        }
 
        fmt_end_value(fctx, row);
+       if (bconf.output_format == CMD_FORMAT_TEXT)
+               putchar('\n');
        /* No newline here, the line is closed by next value or group end */
        va_end(args);
 }

Thanks,
Sidong
