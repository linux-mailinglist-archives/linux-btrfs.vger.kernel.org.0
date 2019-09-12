Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B94B0A2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfILIYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 04:24:14 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:44017 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfILIYO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 04:24:14 -0400
Received: by mail-ua1-f54.google.com with SMTP id h23so7716439uao.10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvN1oj5Uvd7TKjy6jymfvyrHCREAW1XrjRxV9mG0FNU=;
        b=pA0lTVGVvS8IG1YNQOZLu4Rt9jNjz+xgwdW4gDpYmym6YFJkzFdkqJdWp84E8oRzph
         bGq0DZ588gT649eF90CGC3zxwdnU3a8bszlClRXciMbYRS+H/5RM8Zm4QOrwXn6unsGJ
         p7Op1T+LN5t04GAEpKsfx67pw9XrftoxYYntvBXJAmFb7G3af9eJbcMl3Q/BdHA8OoED
         WpVgc0nmSWyXnWMXwmavcy5YALT6DDBh49Qyblcgi1Xz16KSjyZt76gTFsyVDC4FZp3/
         CvfHAHhTP0SewU86YDMzBkQvXyzRppSpsPUq+A5YLRdfn+e0p7YrPmZn9ygdGWve1w3r
         4Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvN1oj5Uvd7TKjy6jymfvyrHCREAW1XrjRxV9mG0FNU=;
        b=mbYRza0+3A1CJFYKSBWgqr10PSAzdkDi06R7xUg4Z7jkP6OFu20jGUJ0gA/EdwpVYa
         liOXhrIAM1xs65WeJ5eslu9zYEnwhnuoDDvqfPMQiF/D0NczVcDoWn4Uh9qldeNAj3Zj
         90y2VNoxx5gOhEtD294CbaTdbB/wIXh/mfI+33BsfBnextIdkg+1N4lHIHZ3iXazre2p
         u7VHdWjnn+QL2pLYmsd1mQ8Awdnnfv6WiIAzJ9fdG52TTKx9O3sQk+kAFJ61C1pf5GsE
         U1jn6MxG/roe0NB4s41tkd0/pX3laZUEMIHfie/m1jKbRj5SZFW2ySIb+WpC6GaPFbq3
         mayQ==
X-Gm-Message-State: APjAAAX3g6ZClgdi7ztbZ9cbHcrU3o+CUAn/0btthRW4PahchJ6g2Aro
        TGYLKkBtfDIugZs4ICeFr27VZhhQe8VaIYca76c=
X-Google-Smtp-Source: APXvYqxlJCN/wgc+LJlW3TEt9gIeJ5BKVY6jkJ2ljpTRprGRf/Oiue2SHdnrw+5nR0b3jvANP0sXDpRtleC0m63EFS4=
X-Received: by 2002:ab0:602e:: with SMTP id n14mr4863842ual.17.1568276652917;
 Thu, 12 Sep 2019 01:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net> <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Thu, 12 Sep 2019 04:24:00 -0400
Message-ID: <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     fdmanana@gmail.com
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 3:51 AM Filipe Manana <fdmanana@gmail.com> wrote:
> ...
>
> Until the fix gets merged to 5.2 kernels (and 5.3), I don't really
> recommend running 5.2 or 5.3.

What is your recommendation for distributions that have been shipping
5.2.x for quite some time, where a distro-wide downgrade to 5.1.x
isn't really an option that will be considered, especially because
many users aren't using BTRFS?  Can/should your patch be backported to
5.2.13/5.2.14?  Or, does it really need to be applied to 5.3rc or git
master?  Or, is it possibly not the right fix for the corruption risk,
and should a flashing neon sign be given to users to just run 5.1.x
even though the distribution repos have 5.2.x?

What is your recommendation for users who have been running 5.2.x and
running into a lot of hangs?  Would you say to apply your patch to a
custom-compiled kernel, or to downgrade to 5.1.x?
