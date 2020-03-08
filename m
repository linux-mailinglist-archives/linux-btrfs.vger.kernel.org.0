Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CD17D481
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 16:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCHPlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 11:41:09 -0400
Received: from ciao.gmane.io ([159.69.161.202]:38966 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHPlJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Mar 2020 11:41:09 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2020 11:41:08 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1jAxyH-000MOg-MV
        for linux-btrfs@vger.kernel.org; Sun, 08 Mar 2020 16:36:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Ferry Toth <ftoth@telfort.nl>
Subject: Re: Howto take a snapshot from an image as ordinary user?
Date:   Sun, 8 Mar 2020 16:39:49 +0100
Message-ID: <d87f9e87-0e77-c758-aae9-f0d069b0e6da@telfort.nl>
References: <58ad5d52-425a-a89d-d042-e9941088828a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <58ad5d52-425a-a89d-d042-e9941088828a@gmail.com>
Content-Language: en-US
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

