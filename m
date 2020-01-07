Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E43132047
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 08:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgAGHPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 02:15:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34235 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGHPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 02:15:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so52667141wrr.1;
        Mon, 06 Jan 2020 23:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3yMHNLG7pwHewdP1frFHQJesrvJGRkiPBj7d5kM3HDs=;
        b=RQfN/Wk4R145DE5gm6KSnpVwgc1Y7+OuI9LkfNpDDbdjtZGBEsrv6pMlo9fi0Mav1Z
         uMmkMaH7V8DNCK7LW+I7sXZvv+k6TFZdZl524Gl5WWi60OUPkSsj1+b835H6sdwJ0XKl
         bgwg6xNE6UvPqeJByqbbbi9Vlq3LVKSwJG4BfLpaHz5YQtLbLzl74d01o1XTzSoZs8BC
         Tp8seHdBFi/seCRJ2L53ICz5M4P2UUy7f/uZeF8XOLu3hpgBeklQwKFgQ9nN++C3ta4e
         xBm8eP6fErveF4UvkeAvM8rmtwxpoAS+fVpUceYdMIkP/69wdh9ZQd522tZkTpnG6P3+
         9Wqw==
X-Gm-Message-State: APjAAAUSR6EwfzRFvsvrr3shEgF6zuyrH7w2D+NsBvUDrnO3f/IqMjkk
        4bOzdMuxcd6v8Y9EsTyYInQ=
X-Google-Smtp-Source: APXvYqyv+aUalrOIady4hQm7l/sNXHhceysXG7eO1uF7DYQTmiGwP17FZkpdmXk4cxtHzJoGLZUCaQ==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr104014901wrp.238.1578381302122;
        Mon, 06 Jan 2020 23:15:02 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-208-11.dynamic.mnet-online.de. [46.244.208.11])
        by smtp.gmail.com with ESMTPSA id n67sm26211505wmf.46.2020.01.06.23.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 23:15:01 -0800 (PST)
Subject: Re: [PATCH] btrfs/140: use proper helpers to get devid and physical
 offset for corruption
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Eryu Guan <guaneryu@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200103111810.658-1-jth@kernel.org>
 <20200106081647.GE893866@desktop>
 <1c1dd1ae-e484-ee02-a7d8-077f95f7d4cf@gmx.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <49f4d5ed-93b8-7660-ba67-d82f282eabec@kernel.org>
Date:   Tue, 7 Jan 2020 08:14:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1c1dd1ae-e484-ee02-a7d8-077f95f7d4cf@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 06.01.20 um 09:56 schrieb Qu Wenruo:
>
> On 2020/1/6 下午4:16, Eryu Guan wrote:
>> On Fri, Jan 03, 2020 at 12:18:10PM +0100, Johannes Thumshirn wrote:
>>> Similar to fstests commit 1a27bf14ef8b "btrfs/14[23]: Use proper help to
>>> get both devid and physical offset for corruption." btrfs/140 needs the
>>> same treatment to pass with updated btrfs-progs.
>>>
>>> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
>>> ---
>> Qu Wenruo has posted "fstests: btrfs/14[01]: Use proper helper to get
>> both devid and physical for corruption" earlier, and I'll apply his
>> patch instead.
> Thanks.
>
> The timing is great since I was just going to ping that patch.

Thanks as well,
    Johannes
