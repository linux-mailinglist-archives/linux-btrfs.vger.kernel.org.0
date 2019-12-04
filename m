Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C9112DDD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfLDO7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 09:59:05 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39160 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDO7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 09:59:05 -0500
Received: by mail-wr1-f50.google.com with SMTP id y11so8970033wrt.6;
        Wed, 04 Dec 2019 06:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Q6AnUjtQjpPb87vHrS/nIu8anJIQ8Gpe4K1K+1ygyuQ=;
        b=qAFe2G5Uol5owd13LGIr/CgdNxbAVAxo2IlveCvJs5a4He5SHBgvNpFzsk9ftn6igc
         GF9wagrHi5gg11oqbm6qWvar8YXvXPCsmsdf4n8HG44KujR4Y+Etv2Y7ZFtSfs6hwy+0
         /hZ+CkEpCNGHMyzdIQtz6mtJwbhtyQBewrCrlUINuaq5syGuew0iVqnABOdsm9YWp7Gc
         tlrxxZucwCjL+IGFZfcA7kcwHsajkCcqoYPLuLeU7Byj2Gmv9wpEW7ftet6KoXX7LFTu
         OsJcq+WtNOzr9u7wK9t/pTQnocEz9RSGMcFbZojOtM1NDp6NO2WFlIgOJw9mVh2AWnqo
         q3Sg==
X-Gm-Message-State: APjAAAUczzwA6q1+xW/Y5CzpYDZGzRMumptD81lbCMaoDM9ufoktOEaI
        R12Ed0I/31qAbwXdly0sL14ps7kZFpM=
X-Google-Smtp-Source: APXvYqwWs+9Xsu2vJunohmq/Q9NrZPIF/NyiEK94Ez0kxgrYifkzRe+yA/gSJbr9xD/LaLc5xzvKQQ==
X-Received: by 2002:a05:6000:1052:: with SMTP id c18mr4567924wrx.268.1575471543294;
        Wed, 04 Dec 2019 06:59:03 -0800 (PST)
Received: from Johanness-MacBook-Pro.local (ppp-46-244-211-33.dynamic.mnet-online.de. [46.244.211.33])
        by smtp.gmail.com with ESMTPSA id l15sm8563017wrv.39.2019.12.04.06.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 06:59:02 -0800 (PST)
To:     syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com
Cc:     clm@fb.com, dsterba@suse.com, jthumshirn@suse.de,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000096009b056df92dc1@google.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
Date:   Wed, 4 Dec 2019 15:59:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <00000000000096009b056df92dc1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

#syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
close_fs_devices
