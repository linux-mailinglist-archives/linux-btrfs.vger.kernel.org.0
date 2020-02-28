Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE45173618
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 12:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgB1LeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 06:34:23 -0500
Received: from mail.render-wahnsinn.de ([176.9.37.177]:40660 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1LeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 06:34:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E4CF7EAC1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 12:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1582889655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfuSi7/BD8ABNsN6+liUC20uer0IbTGTtKBmaqeoYUs=;
        b=hjzQ7gAeaXtkqLS4D+0xro2xvQvmx5bc8D6ERjVE1O932K28Z+DMA0OLpzp9TI09MTNJrs
        F4da85Obxh8V9PdJSU5JeK6a6tB86ZjcrwBF8CNrWPljC0PuGxyOXWb5WxFYIaZmF1jlW/
        nMXgS1DYPV+u0Ko79MxaIV/bkZcKuGux8+y+bvRjpAS2+eI2nUXCuz5q1HhpndoGWLVUVX
        cjwwle7Z6FEkBBDF7XOGXv0FWBJdL+73j4rgXFc9IKUHwZsVNk/M10ByqelBUmzL4G+uRh
        ZFd1pQ593GHSAFxFW+2hNjcp72p3BEBGS2E4kTB6inwDtU4oHAoDKXWu5W7SUw==
Message-ID: <d8c93454fd5680accc6d5eb0217c102a70c3c52c.camel@render-wahnsinn.de>
Subject: Re: scrub resume after suspend not working
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Fri, 28 Feb 2020 12:34:13 +0100
In-Reply-To: <37691afb-bc88-cd7b-b428-4b577b363537@applied-asynchrony.com>
References: <e476b0aec351754b3cd72ed7d9135a6900f57554.camel@render-wahnsinn.de>
         <87a3111e-598d-9a1a-3235-07bc81372520@applied-asynchrony.com>
         <ac8e321bedfc590b96c06973327620244624dccc.camel@render-wahnsinn.de>
         <37691afb-bc88-cd7b-b428-4b577b363537@applied-asynchrony.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, I've updated my kernel to upstream Kernel 5.5.
Btrfs scrub status does indeed show some stats after waking up from
suspend.

BUT,

it seems that "Bytes scrubbed" no longer increases. 
The time left and duration is stuck and doesn't change. From what I can
tell, the only value that is changing is the ETA.

This is on a BTRFS RAID10 by the way.

Is this a different bug?

