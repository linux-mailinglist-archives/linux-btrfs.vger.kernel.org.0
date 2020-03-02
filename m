Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940BE175262
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 04:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCBDpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 22:45:45 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:42021 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBDpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 22:45:45 -0500
Received: by mail-il1-f176.google.com with SMTP id x2so8071243ila.9
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 19:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n88FfMTOnLMt1re668NCyQLMh83JAMNMOYus5mMZRnc=;
        b=tMlzEuMQWcVfOdfmx8EEIyrfPmI7lSurgpljcqcBiXp6oC+Fb1SQp4aeXr22P/dxGE
         aNpRCSs9WrilvOhD/L56Mf7puOCQUS0nfCFonk/eyL41u7eqZ286dOxzEWf3pnzAxvmW
         8th7kBijLp0twYtuq+/O50oBR6MkoMD+WyvRmqJXIgUBmgvqT6bw1s37zv/fH42MrodX
         A+38FTCYzxvT8pxDFHFZYdkvfVFlyXB4xNgK1+CW3qoJe517oGMxTJDNDcz7nz4aqYgP
         lLsi9MIqOuEtV4uDElSxmdDtBZBqEf6XmtL12kPYYncmfmqRppbFq8PXYzd8oYG17QWn
         +vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n88FfMTOnLMt1re668NCyQLMh83JAMNMOYus5mMZRnc=;
        b=pP63g6EZrmGxbw9f+f0QNlRXwCZFoALrkZSJsHgBZb2xms43NxTiwfQ30w/XcJwyw2
         tDpSAJ21RgTWf8pOXRJk7JMbZSlwF/aWQ65Mxb9b6oB4b8wmnL716HG76Sl9ijFXghau
         vRfKgzxkDbBXFcAmy5RSVLmM7MLLMJq9e07iBOLIQhAOhgZGdSr3VUrGYyrUxx77QKJ2
         ZrYsTVf1dvjTZXGLZEiUr5D1AgaeEKUiKOgjltnVPxePKZN0MXl2Mtpj2VHmRHsBqSE0
         68dCidmXWmVrskmGdunOhiw3ZZCbUZDlR80IEG+Ha0+gUCbxr5JdeYc62IEKA495FJhp
         YYlw==
X-Gm-Message-State: APjAAAU2IIgrivQns8fkkWk6IMjcscsjGWTpbqCVdXlkKOLMPr/eZ6mD
        ASNsui0bUUKCpoBunQhlxC6JK5Voqh+ZY7rIlcY=
X-Google-Smtp-Source: APXvYqyCSNMIKGZsA6Z2wMk4IMd88HxUlJHwuA+jPgP5EXLdyhvJyQJM51WZAVdPxc9UKEyfHmZ6rB3xLWjrzrmInaQ=
X-Received: by 2002:a92:af8e:: with SMTP id v14mr14326702ill.150.1583120744623;
 Sun, 01 Mar 2020 19:45:44 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
 <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com>
 <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com> <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com>
In-Reply-To: <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com>
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Sun, 1 Mar 2020 19:45:33 -0800
Message-ID: <CAG+QAKUuLz0jewrrBOxuQQUvbSBBBrxBZgfabFzn7moJ9Ka55A@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 6:38 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
> ...but that's what I'd expect the balance to do?  If Block (Chunk?) A
> is on, say device 1 (4TB) and device 2 (2TB), why wouldn't it move
> Block A to the new drive from device 1 or 2 in order to free up space
> and balance/spread out usage across the drives?  Is that not what
> balance's purpose is?   Or is free space required on 1 or 2 in order
> to move the allocation to the new drive?

Am I just not taking COW into account?  It rewrites the chunk to
reallocate so needs two destinations?  There is no "move"?
