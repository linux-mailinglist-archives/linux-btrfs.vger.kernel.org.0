Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1014352FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJTSuY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhJTSuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 14:50:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9912C06174E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 11:48:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so16819169plb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NQ1EuHM5IgMVtLK2y5+wVaFDOFZIiofPZ6eBCmdV3Pg=;
        b=zhwmnUwjzipb3ftyn4a+qKNhhOY1B27CWv9LoO6StyINljAjpqYWLauCWORB6O0MPv
         bwsLO3e1ez3dWyoLlXnmgWoKzWZWg3NNoJgV7eT437Ql0WO4e8two+iA1jUWhNoHGCDt
         Q76AoWPKZyVX/KzpBU4djhaJ0U0FmZ0FznbVPH2UzpWeBx4x+A5MtV9DbErSFLrnczjE
         36s7GDUAhqZQnz+W7q6YOx+41YXBP/SPM71iuedVT7ibQNySrpewODLJXiiBNSHzajWG
         cFtFWra0hgaxgdN3GhpU220SlgK5A2H+ZRW13OX9s5A0RBU29j1I1Ok5/e8Re9UIU/iG
         5E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NQ1EuHM5IgMVtLK2y5+wVaFDOFZIiofPZ6eBCmdV3Pg=;
        b=uOVKh5eGtnnqX6UCrdBERtafiyCT12Pr4GeUpHElqPyvjHOPviAOT2TvKfr8+NeR8H
         +C1Gbzu65sOTbIijEk/2vosFt8/C7PFakI68M4aXt4qbo14R8IGJ/QnOSIZoxRRwpw3j
         NQOW6tv3GR+VvguAzLJ0P9ktQNmPsGjkoy9bYLwARZ9tchb+x/c5XA6WcKcsd6xD8IZM
         HfsaVVDnRU2JZ9K2eb56enfkcLuDWIB7CDwFay11JMoBSEXSQrMUl1tHmNquGugSJA6X
         gD2AaPNROka45SqoH7T/25CaBfesYljMHaVncn4eKj6RC6bHh0x56IYgC/PnlGss1Ihn
         JT7w==
X-Gm-Message-State: AOAM532exukXaatwbH/TwCsVvhficBZws48pxHjeOzRiWP6hsd0f88VC
        7N7V4UZDPQg8k5mb99PRVmasYQ==
X-Google-Smtp-Source: ABdhPJwrQB0DLaQzr2JASowUXfaOc3ZJfTfRTYifLBwS/p/C6efRjvvNoC+XDq2kIkE9L2MGydpFxA==
X-Received: by 2002:a17:90a:d311:: with SMTP id p17mr659231pju.155.1634755688287;
        Wed, 20 Oct 2021 11:48:08 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:be9d])
        by smtp.gmail.com with ESMTPSA id om5sm3225914pjb.36.2021.10.20.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:48:07 -0700 (PDT)
Date:   Wed, 20 Oct 2021 11:48:06 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 01/10] btrfs-progs: receive: support v2 send stream
 larger tlv_len
Message-ID: <YXBkZmARzs4jGA92@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <8729477d23b83c368a76c4f39b5f73a483a3ad14.1630515568.git.osandov@fb.com>
 <d628363e-295d-8e84-d6f2-85501ada24ed@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d628363e-295d-8e84-d6f2-85501ada24ed@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 04:49:38PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Boris Burkov <borisb@fb.com>
> > 
> > An encoded extent can be up to 128K in length, which exceeds the largest
> > value expressible by the current send stream format's 16 bit tlv_len
> > field. Since encoded writes cannot be split into multiple writes by
> > btrfs send, the send stream format must change to accommodate encoded
> > writes.
> > 
> > Supporting this changed format requires retooling how we store the
> > commands we have processed. Since we can no longer use btrfs_tlv_header
> > to describe every attribute, we define a new struct btrfs_send_attribute
> > which has a 32 bit length field, and use that to store the attribute
> > information needed for receive processing. This is transparent to users
> > of the various TLV_GET macros.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  common/send-stream.c | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/common/send-stream.c b/common/send-stream.c
> > index a0c52f79..cd5aa311 100644
> > --- a/common/send-stream.c
> > +++ b/common/send-stream.c
> > @@ -24,13 +24,23 @@
> >  #include "crypto/crc32c.h"
> >  #include "common/utils.h"
> >  
> > +struct btrfs_send_attribute {
> > +	u16 tlv_type;
> > +	/*
> > +	 * Note: in btrfs_tlv_header, this is __le16, but we need 32 bits for
> > +	 * attributes with file data as of version 2 of the send stream format
> > +	 */
> > +	u32 tlv_len;
> > +	char *data;
> > +};
> > +
> >  struct btrfs_send_stream {
> >  	char read_buf[BTRFS_SEND_BUF_SIZE];
> >  	int fd;
> >  
> >  	int cmd;
> >  	struct btrfs_cmd_header *cmd_hdr;
> > -	struct btrfs_tlv_header *cmd_attrs[BTRFS_SEND_A_MAX + 1];
> > +	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
> 
> This is subtle and it took me a couple of minutes to get it at first.
> Currently cmds_attrs holds an array of pointers into the command buffer,
> with every pointer being the beginning of the tlv_header, whilst with
> your change cmd_attr now holds actual btrfs_send_attribute structures
> (52 bytes vs sizeof(uintptr_t)  bytes before). So this increases the
> overall size of btrfs_send_stream because with  your version of the code
> you parse the type/length fields and store them directly in the send
> attribute structure at command parse time rather than just referring to
> the raw command buffer during read_cmd and referring to them during
> attribute parsing.
> 
> This might seem superficial but this kind of change should really be
> mentioned explicitly in the changelog to better prepare reviewers what
> to expect.
> 
> 
> OTOH the code LGTM and actually now it seems less tricky than before so:
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> 
> David if you deem it necessary adjust the commit message appropriately.

I clarified the second paragraph to:

Supporting this changed format requires retooling how we store the
commands we have processed. We currently store pointers to the struct
btrfs_tlv_headers in the command buffer. This is not sufficient to
represent the new BTRFS_SEND_A_DATA format. Instead, parse the attribute
headers and store them in a new struct btrfs_send_attribute which has a
32-bit length field. This is transparent to users of the various TLV_GET
macros.
