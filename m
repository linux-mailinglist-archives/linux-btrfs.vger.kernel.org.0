Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC817D485
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgCHPwG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 11:52:06 -0400
Received: from mailfilter04-out40.webhostingserver.nl ([195.211.73.157]:10809
        "EHLO mailfilter04-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgCHPwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Mar 2020 11:52:06 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2020 11:52:05 EDT
X-Halon-ID: 83957d3b-6152-11ea-a6ff-001a4a4cb95f
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter04.webhostingserver.nl (Halon) with ESMTPSA
        id 83957d3b-6152-11ea-a6ff-001a4a4cb95f;
        Sun, 08 Mar 2020 16:36:01 +0100 (CET)
Received: from [2001:981:6fec:1:894e:adf7:dc:7e47]
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <ftoth@telfort.nl>)
        id 1jAxyD-006ve8-0G
        for linux-btrfs@vger.kernel.org; Sun, 08 Mar 2020 16:36:01 +0100
Subject: Re: Howto take a snapshot from an image as ordinary user?
From:   Ferry Toth <ftoth@telfort.nl>
To:     linux-btrfs@vger.kernel.org
Newsgroups: gmane.comp.file-systems.btrfs
References: <58ad5d52-425a-a89d-d042-e9941088828a@gmail.com>
Message-ID: <d87f9e87-0e77-c758-aae9-f0d069b0e6da@telfort.nl>
Date:   Sun, 8 Mar 2020 16:39:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <58ad5d52-425a-a89d-d042-e9941088828a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

Op 07-03-2020 om 22:21 schreef Ferry Toth:
> I am generating a btrfs system image using Yocto.
> 
> I want to take a snapshot from the image preferably inside a Yocto 
> recipe. The snapshot I can send 'over the air' to the remote (IoT) device.
> 
> Now I am able to loop mount the image file using udisksctl as an 
> ordinary user, which mounts the image under /media/ferry.
> 
> However, the owner of the mount point is root, and it appears I am not 
> allowed to take a snapshot as an ordinary user.

To clarify, I know that I can chown the mount point after mounting.
But to do that I need to sudo it.

> I think it is obvious that I don't want to run bitbake as root.
> 
> So what is the recommended way to generate a snapshot without becoming 
> root?
> 
> Thanks,
> 
> Ferry
> 
> 
