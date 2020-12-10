Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36752D53C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLJGYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:24:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:48881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLJGYt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607581397;
        bh=SatdtFJ/UrIydCTSQ5KHZ+NDzZzmgOUFT+34vm6rbB0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:In-Reply-To:References:Date;
        b=jIlvn8+fsrHECBq0nd8oq1qfXqVQKV1laqBzMsH+RfguORrhVPTPiuQrwjugUxhRe
         D7XvRJJ0oZGQ88yoejEe+ZOGG7wuE7natpEcT/bCE+0MjA5GSAc14i8pgX7OOHzu/y
         pRN3/ZJ2fME4rdV2HTCF9cIFmRDYX4yQgp06PUqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([77.8.221.62]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1knnK309n0-000bXU; Thu, 10
 Dec 2020 07:23:17 +0100
Message-ID: <1d40f2a14487b6f052c2be84a38b5fff18d088a3.camel@gmx.net>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file
 or directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
         <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
         <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
         <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
         <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
         <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
         <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net>
         <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 10 Dec 2020 07:18:16 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SEm+32vqIb3QFPIrBtHg2PLnPuGZDEJqkYmPbyHzfe/LtZgsz2C
 3uXN3NK4EYStF7Kn5c5SMrV25dFQwtpfEQgh0iZweJ3qcdoAzw6ORksjJ2vGPB6NHsO83Oo
 osi7cAq/n6Vu9AphGUOHyxU4QodUWMsFM2TZb4tVFi7sLv2wdanRFzPMwpTwwJxmYE0OKym
 jP41xjem5Zq9hlOTl8L0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tYU4UMxfBC0=:si6nJqkHlFo1BADsF+DMk5
 OHVOWwHjAd/SjDILTAgKFXcSQLvkcq198ZEmnIXZKLmwOwuVY3ixT9J2ekyRjS7eplhkkMSBP
 V4URf2WLHtl2A9XXMoRaBhdHwPKY77CW8ZN278ypu26UBrcE1eUid9PWRI1Fn5kTZLJ6yQnsP
 Z/HTF5NAJFvvAyEfIa7dAXqcGP+5tsIfNRbTvUgq7La+uiFcOLRemwcnqtWZtZlhpltm9LfyR
 U+F9ywgDodH9c8kUjcl+iSWOilJ71j21lNOQbVB+hCe4KMV2+ZBaRhp83+Ba+Mzbr+h3//5Dn
 /FSRKvKqHe39FwFv58+qVtcMyiZ2Jus/S4aNkp9ai/THj4twjS/l3W0Rj3paiIpYlbzO0XPiS
 MPtTUfid9oid5dmJIrx0eY1UxZCagqHclg/LukAJf97L1mqcpcgabNHdxAtT3QSS9rs6DiL9+
 bVBUy30NHODakSg9/NuewScO61Sz8drNAdYDTlkSbV2iu7GtheTSyd7Pvm2eYQIqIwy3OPuet
 ob21qLNL9v1bdN73WBABqQT6CF+ZNUl4DhSB7s4FD8tgnk2OJxuss3wrU8RXO5KdacGg0CTov
 NbChEBIUED0zcfgIcy1YU1lEOf93ji/d8gDqCJjghLyELTGNa5JGHZKOu+Y3V7GilhWV36jfa
 QCsrOEDTb+tuzrRpnMbkIuaNQHEWdGvXLKWdDH0lqxB9Oodm24TvtYbwmbWzsm7HF6C8hMqBS
 C96FaYf4Kc0Lc/Y3FhC8rVehc1wOE/X02TrSgwce4T7Jyf15kbOEiOCpvF5pMVmBtZhdUUB+g
 ep8dG7ZiO3K6Bfwc+u/3IfYUVZIdboiTI4o2IMo8FhiMvI+tezcjNYlUvevqyyi0oRIJgGN0o
 TBQ1WNq4jrGod1KW171A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2020-12-09 at 10:29 +0000, Filipe Manana wrote:
> So to confirm if there are other problems, you really need to let send and
> receive processes finish (don't kill them). If they finish without failure,
> then check if temporary directories (or files with the same name pattern)
> still exist or not.

Ok, it seems to be working.
Thank you very much.

Can you put a note on the list here, when this is going to be released and to
which version?

Best regards,
Massimo

