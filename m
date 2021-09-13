Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A89408567
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbhIMHdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 03:33:51 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:35657 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbhIMHdu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 03:33:50 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id F015521037A; Mon, 13 Sep 2021 09:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631517404;
        bh=8wD8zCLsVkrmugSYtSg5XtVJ40D5oaN6CUXNCsurFn4=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
        b=gkHN8BS9d4A8Vc29zbzzDXldLvvV4QcQtMwNtLN946VG1gLMvyR9PuVTflS1XCAEo
         qzsqr+PWwgea61qxy63jDwlkfQxGa9zOe3wCVIYvFm0MSeaYQctDMIfa2MdgzJHY0b
         9NSmwAZOCLLGAKEZ8xsLSfscwP81YgT1EP9WRVUg=
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Sep 2021 03:16:44 -0400
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <5a1cc167-0b9d-8a89-11e4-cfe388bd2659@suse.com>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <02f428314a995fa1deea171af9685b9a@linuxsystems.it>
 <5a1cc167-0b9d-8a89-11e4-cfe388bd2659@suse.com>
Message-ID: <75440780864f97ea54d12ff95a395864@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il 2021-09-12 19:55 Qu Wenruo ha scritto:
> During the backup, have you checked the dmesg?

Yes, the only error was the "No space left" I mentioned in the previous 
message.
