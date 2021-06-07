Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9088839D47E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 07:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGFzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 7 Jun 2021 01:55:01 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:58424 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGFzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 01:55:01 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2021 01:55:01 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id BBC7516005E;
        Sun,  6 Jun 2021 22:47:07 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 94233WHieqS7; Sun,  6 Jun 2021 22:47:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 1200C160064;
        Sun,  6 Jun 2021 22:47:07 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rU0UWHVL2jpA; Sun,  6 Jun 2021 22:47:06 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id D5E9116005E;
        Sun,  6 Jun 2021 22:47:06 -0700 (PDT)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Tom Yan <tom.ty89@gmail.com>
Cc:     48833@debbugs.gnu.org, linux-btrfs@vger.kernel.org
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
 <20210604201630.GH11733@hungrycats.org>
 <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
 <20210606054242.GI11733@hungrycats.org>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#48833: reflink copying does not check/set No_COW attribute
 and fail
Message-ID: <4354c814-9f9f-0c26-fb11-36567da6f530@cs.ucla.edu>
Date:   Sun, 6 Jun 2021 22:47:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210606054242.GI11733@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/5/21 10:42 PM, Zygo Blaxell wrote:
> If cp -a implements the inode attribute propagation (or inheritance), then
> only users of cp -a are impacted.  They are more likely to be aware that
> they may be creating new files with reduced-integrity storage attributes.

True, although I think this aspect of attribute-copying will typically 
come as a surprise even to "cp -a" users.

> If the file is empty, you can chattr +C or -C.  If the file is not
> empty, chattr fails with an error.

Although coreutils 'cp -a' currently truncates any already-existing 
output file (by opening it with O_TRUNC), it then calls copy_file_range 
before calling fsetxattr on the destination. Presumably cp should do the 
equivalent of chattr +C before doing the copy_file_range stuff. (Perhaps 
you've already mentioned this point; if so, my apologies for the 
duplication.)

