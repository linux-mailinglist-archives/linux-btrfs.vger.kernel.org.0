Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B494502BA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiDOOVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiDOOVH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:21:07 -0400
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 07:18:38 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2387CF486
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1650032137;
    s=strato-dkim-0002; d=ikherbers.com;
    h=In-Reply-To:References:Message-ID:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=g/guidJZ2/W/wbQ4ZugSOZs59Su/YAjOmiIuSgnrS2k=;
    b=kzCrqIzo+c647F65pURGAmH81u3lyqa0knX//sH6gSsmVLE+rlsTrm8Dqthhc4djsb
    yV6UlqVC4e+7xlWjiasfEUNVfyBz7Hn0+Wn5bCTp6gkLoMgbwOQ9k5dwKp/SjwtvoYWu
    sCK2eYYJDXd9R6DoUGX2LKSy6yM0evHNT6FtLIBSylUDWop8LN4hcdgtAtNKwcOYE0WB
    wXVmT6XJeJOK4hJZBMDj+k5hhT6cmvwF+tsWUTYlbelu52ogdUvCAoS82AsAdA1QO7Gy
    NqwBi8Tw6WDDEmSP5/YrT9mZHkiBdePTcyON/mNPfCfrWQlK+n6g1IsDeBENxormLcmd
    VxkA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IUwNfkitaf3qOWm2b/jA5tveVwUUcwH3PkiYp6DPxTDDEo4xO9elHkvI0r6JTEEzUZyUhv89yjMIDm0SCr2iIDXve3dlq/bY42lw"
X-RZG-CLASS-ID: mo00
Received: from lambda.localdomain
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id Y536afy3FEFbA1d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 15 Apr 2022 16:15:37 +0200 (CEST)
Date:   Fri, 15 Apr 2022 16:15:36 +0200
From:   mail@ikherbers.com
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs write time tree block corruption
Message-ID: <Yll+CD/h6YmNX5TR@localhost>
Mail-Followup-To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1443235259.231086.1649984361804@communicator.strato.com>
 <4daec659-c1d1-b100-89f7-8a2a2e3e1fc5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4daec659-c1d1-b100-89f7-8a2a2e3e1fc5@suse.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-04-15T10:04:01+0300, Nikolay Borisov wrote:
> 
> 
> On 15.04.22 г. 3:59 ч., Maik wrote:
> > Hello,
> > 
> > I just received a corrupt leaf error on my root filesystem:
> > [29854.502499] BTRFS critical (device dm-0): corrupt leaf: root=2 block=579036020736 slot=86, unexpected item end, have 16789244 expect 12028
> 
> This suggests a memory bitflip
> 
> 16789244 = 1000000000010111011111100
> 12028 =    ^          10111011111100
> 
> The good thing is the tree checker caught this before this corruption went
> on disk. I advise you do run memtest.

Thanks for the pointer.
Indeed my RAM was faulty :(, but the filesystem is alright.
Thank you all for this amazing bitflip detector :)!

Maik
