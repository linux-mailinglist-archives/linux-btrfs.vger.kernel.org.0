Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801CF16A78F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBXNsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 08:48:10 -0500
Received: from mail.render-wahnsinn.de ([176.9.37.177]:35052 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBXNsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 08:48:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 675ED7C4E0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 14:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1582552068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3YMKVMDdRAf4MJcr3/bOSSGj0KLR3mKdx3KvOBNfQk=;
        b=ReHhtF+0o5Vi8khazV4u8z+FIak/eSAc/abAbV7P+ORee8bKlkkqT9OszVQFXiXIxFoULw
        R2s2DvQFUtaouGHZnI2sF8ovZpNYELVLRZUNRUh5PYBFwlaBTCOhGHojfNgQ7zUJ+Yd78+
        pGQvGwfvksPood//DYfWqbjDz2sUYSgGPFFj8393DqC/KYVnYhrTj6K4fZIf7DlJw4ZmBD
        9WitkTrYK4k+6v54mwvS8Gs4p2/Cj3m2VhpK607DD3sWagFODXDfDunQlvOYfcCx5Gi+gj
        JCxAwZ2YMer2gy+hbKyil5aqifQgGLpW7Xdb0z/J32f1k/ZBHEXDuyqTV1Wqhw==
Message-ID: <ac8e321bedfc590b96c06973327620244624dccc.camel@render-wahnsinn.de>
Subject: Re: scrub resume after suspend not working
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Mon, 24 Feb 2020 14:47:24 +0100
In-Reply-To: <87a3111e-598d-9a1a-3235-07bc81372520@applied-asynchrony.com>
References: <e476b0aec351754b3cd72ed7d9135a6900f57554.camel@render-wahnsinn.de>
         <87a3111e-598d-9a1a-3235-07bc81372520@applied-asynchrony.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm assuming you're referring to the version of btrfs-progs and not the
kernel, right?

Am Montag, den 24.02.2020, 11:08 +0100 schrieb Holger Hoffstätte:
> It *was* a bug which has been fixed in 5.4.14. Current is 5.4.22,

