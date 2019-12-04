Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2935B11376F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfLDWLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 17:11:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39998 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 17:11:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so801596lfy.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 14:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVKObvByZzFzQATgpFkWu+FlO7bTB3f8dGCU4GRmh5k=;
        b=TstVzrTsZMBsI+79K7XQiFsk5wAWHI8jZ3/n86k5s/j1Ke35zW7BNWoF4VbWLHQJrw
         NyDyjN6r/GAKGlGMDRy2k88nRlzmBKbK8iEijPyGmwkUsn5cJQnZA3/30zVYWQf+Dq/Q
         ev2hZiA9uM2arJtS/4AqgcQir2KpWZI078F4bf56qhzKzRJ0YUioUY8vEjvdH4NcW9g4
         DcJY37E5q1c4CxaH030ReZrgLbV3yIQ8MCPPP2AYxdkqKUt1jpqvhH9SUzt3SSPnCdZo
         2FmuISHat0pyc0BnTCa6tO+qlChdal1GEvOmcFpChKcAW9lTW0aR6mmsxAnXygQ9Trxz
         UENA==
X-Gm-Message-State: APjAAAVo1p7hKVX37xsTQXxX3RP4XhhdqchNMsT3nAj0r2Sxch/PfIHy
        bS9NyVX2tSYlESFkTlkAfL2oTZzs5h8=
X-Google-Smtp-Source: APXvYqz7w5caDzTYaHWmB+hit3po3Mv1Hxsfi4zATwcaBqrPsZs19SQzQ3T3vKkFu1TVRFnSJl49Dg==
X-Received: by 2002:a19:5057:: with SMTP id z23mr3363986lfj.132.1575497499571;
        Wed, 04 Dec 2019 14:11:39 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h24sm3840876ljl.80.2019.12.04.14.11.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:11:39 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id r14so816388lfm.5
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 14:11:39 -0800 (PST)
X-Received: by 2002:a19:3f16:: with SMTP id m22mr3321731lfa.116.1575497499149;
 Wed, 04 Dec 2019 14:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20191202034420.4634-1-ce3g8jdj@umail.furryterror.org> <20191202034420.4634-2-ce3g8jdj@umail.furryterror.org>
In-Reply-To: <20191202034420.4634-2-ce3g8jdj@umail.furryterror.org>
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Wed, 4 Dec 2019 22:11:22 +0000
X-Gmail-Original-Message-ID: <CAHhfkvzvtDcg7Jv=E3fm4mWnHT80VkGxwEX=6akbebA_Zno3kw@mail.gmail.com>
Message-ID: <CAHhfkvzvtDcg7Jv=E3fm4mWnHT80VkGxwEX=6akbebA_Zno3kw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: scrub: add start/end position for scrub
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for this! I've put together a script which uses the added
switches to rescan observed errors in dmesg:

https://gist.github.com/CyberShadow/648a040103fb08738783b6435da376fe

Though, the approach described in the cover letter is probably a
better idea than what this script does.

On Mon, 2 Dec 2019 at 03:47, Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
> +-s <start_pos>::::
> +set start position by logical address (btrfs extent bytenr, default 0)
> +-e <end_pos>::::
> +set end position by logical address (btrfs extent bytenr, default end of filesystem)

As mentioned on IRC, I found it confusing that these use the term
"logical addresses" to describe what the dmesg errors refer to as
"physical" addresses.
