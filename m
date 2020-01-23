Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2362146F7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAWRU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 12:20:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41371 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgAWRU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 12:20:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so3983096wrw.8
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PirmED6yMeVPueQhTtvEB+gmnsc6AFMwmm6FuClU8WM=;
        b=sNcPmuOof5xd9h0/hnadphzoCsJUpizDFitT61ZN1zFWUlh2OKt7hM2RDN0g6n7Mk+
         NYtcFmmK67V0Jb1nr7RsGenw+TxXfZSw/hbyyG+azuBGh4nNT3UNIkUnBwZRIPWJldn+
         AdXMwhO6BALqjNBxAkN2ybPiTPYQm/lXicOYYN/+1JRUqy95Ucw/SVCRr8QENv0Pgz6w
         ePS6/dsEo6WBcvYkmFAsZ5jzCTEParUXxFD6fYKU8S+IbhCYkyOHE4BSv/9Gs7pVquEE
         oEziF1sthPh7ZSiLvq8Vl4CoEyXyxrkwfRq/9Vf0ImwdIN8pZQ4b/Wma8MKpT8o315nA
         TV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PirmED6yMeVPueQhTtvEB+gmnsc6AFMwmm6FuClU8WM=;
        b=r5jdjh2UavOrNwXwfuW/j7GufYt/JH2bJ00Qef9Phvl0HNl/3GiGFO5EupdjlZyOHv
         Y1pVAYGts6VVTSSkHnvinc+SPfqJRrYBmHmlSClxARe1dM2X7IgkRITE9crGI9uKMnQ1
         3tMbaD1x+E0MDbzVGXGdycScEqrN12WHxdqSYFKf8LJdmjf7TxqjIozaP1WqJ2+eL6Gf
         3qw9cAcsoKxf4d+xLzXufYev/1hqfLUn1cti4XIprRxdsCEDIIXy17wTASjPLwB1W4z+
         XEjVVBxIsnDlkKn+zTeJNTEjpZiC1TrdpqK2Te5WDxEbaKGMoiwLOvPUruAW8YPKvuWn
         xaRw==
X-Gm-Message-State: APjAAAV7r9uvrvyzbtGy0H7V471K73hGWgn5r48slIcwIyy2H+32MwRc
        0m88GOx4U4g8YsRaB8VoMpaFjnQd3xKw3MM5ZgRW+sEq9O8=
X-Google-Smtp-Source: APXvYqynjUfxWtGvYurtqrOrrs/lswLnN7Y3WWmfSNrHMPerXbUf9DZ9SbG2Ff3UwuadJucrOScT2pvBrfB+deWiuLM=
X-Received: by 2002:adf:f308:: with SMTP id i8mr18465744wro.42.1579800055866;
 Thu, 23 Jan 2020 09:20:55 -0800 (PST)
MIME-Version: 1.0
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <20190506113226.GL20156@twin.jikos.cz>
In-Reply-To: <20190506113226.GL20156@twin.jikos.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 23 Jan 2020 10:20:40 -0700
Message-ID: <CAJCQCtSLYY-AY8b1WZ1D4neTrwMsm_A61-G-8e6-H3Dmfue_vQ@mail.gmail.com>
Subject: Re: Hibernation into swap file
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 6, 2019 at 5:31 AM David Sterba <dsterba@suse.cz> wrote:
> for the reference https://bugzilla.kernel.org/show_bug.cgi?id=202803
> and https://github.com/systemd/systemd/issues/11939

I've read these, but can't tell if it's still necessary to manually
use 'btrfs-map-physical' to find the correct offset, and use it on the
kernel command line manually? It does sound like contiguous extents is
not a requirement for hibernation to a swapfile on btrfs. Correct?

The idea I'm evaluating is a way to dynamically enable a swapfile only
at hibernation time. That way there's no swap thrashing during normal
use, yet it's still possible to support hibernation. It'd be necessary
to insert the swapon quickly after a request (or pre-trigger, maybe by
upowerd) for hibernation, so that the various systemd tests already
find a suitable swap device for the hibernation image.


--
Chris Murphy
