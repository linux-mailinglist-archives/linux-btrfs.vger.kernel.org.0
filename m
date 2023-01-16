Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFC66B6F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 06:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAPFuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 00:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjAPFt7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 00:49:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C2C9006
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 21:49:57 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9UK-1oPBix12ma-00s7uj for
 <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 06:49:56 +0100
Message-ID: <91f22f9d-26e6-e649-7323-26352b2ffb62@gmx.com>
Date:   Mon, 16 Jan 2023 13:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Deadlock scenario for __btrfs_map_lock(), and remove the extra mirror
 (from target device) in the future.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1rBMTRcJ/ZOBhmlQ6yUUecORiAEBC/M4NWNoJU/Kmud6Kfrp1oG
 Rn/zXXkpoBrZtz9mI0JPznEGcY+KlTuVG8G8igPI3270GYRbmo3ZBqZMxujPW/578O9bRj9
 qi3idDTNg1hYV4ZuDnriwEYF7nYJIrB1GHIizUNhs3Fa3cf4YKG+PUX6UiaDX7PvoPqnSh6
 QzEXxfZKew0ZcpyWohF9g==
UI-OutboundReport: notjunk:1;M01:P0:1HQDBOJqywA=;TxgxjuKsInTwx2tsjRIaVdcJWJI
 CS1Yb4uwWK/S+LTyNF91pAQ0/DUECLm2MfD6xN8kJq9PX7K1qZGXNBB15Uxw7xzYMG8Xv3wVg
 iiEtvCURWHNBbXzHoUExF5dyx9D3B+vu+oWC5GG41PxEKpXoQczDoBbihvbRmC9z9GNozDne7
 v/oECDdcERcelgtK9c4eSzatk0dfUjWsRgMoz4YzJnKaGuwoyQ78hM9lgWOAu4M3tT7EW3cKX
 0TUKCU9HQkHPl7ndNlw51pCNTrlhJHqJpqpZcPXLZlslMMkPEZEjxTlhVc1u3tI8GzcLers8C
 AwxUsAB4cz7RKmXQ/ubMRN6P8YXPFWIqOkJpXWQhJLWaJYJ0wypDKPFqPBAiN32iMHEWJNB6s
 fXVZx7t/OM98pSULZmy0mZTlW0m89PBhahjetJYVVy1PHv0+bezR8xNtoxpZJx8IBuEgiaLb/
 37e/2Q9FAY42KEGdtTNOQVlTx2GjqllBJ4OlCwEbMwlQa7wYz59lBZBzhKfux3s9W0NKzymTK
 0I5RSNPXcihPuVMT88wktL0QgUQpkDDped4lrY8mhS1LXKuJOC8NZJqz3yoBnXJkNQq/Nk+XH
 W1zIYcCm+g1kKqMuCyhDGu0ACcugqOlsVv+x6NdXkIa1OIXkULsPIFmkgTWWhID0LpYDFA7z+
 6djxgLD595RJ+/yMH2yKvPIc9WoERbpdI9v1XCLkbp1sUZM+KjyXFx6EYIYUZbNzXg256+RDq
 sWqhLxMbVtbmfVKF/7fMuMUAErThQ6skLH4WzDSbubNU+DrThgSb2KCyW7wGPGwpMsz1YONDv
 7x0zUD43LheHccO7cdYCJm9a9MbPyY+M1XrwVOt6fNsWIfHp3Fd1OHR9nB9GuQM6gio1ySSLP
 D/apLxiKsHZ6lNOf8/4W62d/4pxeq6obO1DT0vaIBMu6dcjGT6QSuwWx/gYo7glA5cBX/fX9g
 0Q8Mr1yApNmZ/C5Lj40PDtb5eHY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

During my scrub rework (read path using btrfs_submit_bio()), I hit a 
deadlock situation which can happen in replace.

Although this situation can only happen when calling btrfs_map_block() 
during replace, currently we didn't do that inside scrub, so it's not 
possible to hit yet.

But it should be possible if we trigger read-repair during replace.

This happens in the following sequence:

1. We found the error in the sector

2. We need to read from the next mirror

3. We can use the extra mirror from replace target device

4. We call btrfs_map_block() for the extra mirror
    The the following call chain happens:

    __btrfs_map_block(mirror_num = 2)
    |- down_read(&dev_replace->rwsem);
    `- get_extra_mirror_from_replace()
       `- __btrfs_map_block()
          `- down_read(&dev_replace->rwsem);

I can understand removing the ability of using replace device as a 
target may be too large a change.

But we should at least not call __btrfs_map_block() inside 
__btrfs_map_block()...


In the long run, I'd say using replace target device as an extra mirror 
is not that beneficial, and can be removed for cleaner code.

Thanks,
Qu
