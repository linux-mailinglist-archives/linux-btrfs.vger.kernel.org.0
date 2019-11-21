Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD835105D76
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 00:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKUX5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 18:57:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34206 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUX5z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 18:57:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so6584860wrr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KccUvMAFfZ/3kvmtVb84XWCLak+x0LJP/7PXWnw26mc=;
        b=p3Zpns8tHzqt4zeuGeGuEV9o00tK3FUdFPlNxyjY/Rs8KDAdJJ0701dTC1PZz6FZI/
         nlmF7jSX18OZXmYZgnTSXcc8odGl86Kq+zHv4S1WFWCQNq1G9+FK6QoRfd3tr5IcergA
         PzfFkr0td8Uh0is043FN9p6QScvIo+rglPloLCMHwQU/o2WuOTlIpwJWPMgBwwbhooUA
         +TP/fpS54YxEb8DIPaqQGchClckFpOCe4Li/mr20mfV03TFDGt/vhY9h1dNLEXHYCuSJ
         3OiMEj03s2MGRpEbLiS2GCBdfF+2rQTFsKiStcgAimi/tm0sKhWXNC2jasFg+TC/a3K3
         d4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KccUvMAFfZ/3kvmtVb84XWCLak+x0LJP/7PXWnw26mc=;
        b=InpSTiFP/zIpsF38vZ141Maf8ZjDnHHKzWUsqdz+atJT5/C96sOic6lYQiZ9fVAaJw
         YAQUkB/6Jih2f6+ocGO+jbPhKYy1I0QsX7D7sxyG4s+JdATFpMCcH1RcH0POHbsOR4AY
         kcimhO0AI6PpG0FAXHZcz7ITSSXChEi36Ue92YVPFBJVpw2fPdiqEQPYpPAOK4kxQCrQ
         HR8NP8vSXHt3HjDGrCgYIuHt69ZG3RxYU2J17uDa2WGY+6pe/Wc013EvzAPcW219Y06f
         XNO0JnxjgUNPOnp4YEK7o7xZvQGmgDY4k04yQpndtfpV4A+nzxa5uuvDgROtIKyuJtev
         qSZw==
X-Gm-Message-State: APjAAAWrdCRsVQl+Fcxv4TRIsv8KmbMrnMLV9bQ9z8mw6EjnwwZQRW8/
        3Fej0bRxsr2FbGpacYtGL/+Fds+N
X-Google-Smtp-Source: APXvYqx896GS+QKLGHWNGdGEwmsax1Q7f3FfIe9ciCaV0gJ3XELoRxh/xr3NxqEqz5CSQlNWeiXhkw==
X-Received: by 2002:adf:e886:: with SMTP id d6mr7567186wrm.112.1574380671750;
        Thu, 21 Nov 2019 15:57:51 -0800 (PST)
Received: from ?IPv6:2a02:6d40:2ba9:e00:5c88:4d66:ec41:3562? ([2a02:6d40:2ba9:e00:5c88:4d66:ec41:3562])
        by smtp.googlemail.com with ESMTPSA id j3sm5139672wrs.70.2019.11.21.15.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 15:57:51 -0800 (PST)
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
 <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
 <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com>
Date:   Fri, 22 Nov 2019 00:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 21.11.19 um 21:30 schrieb Christian Pernegger:
> Definitely enabled, then. ... ... ... There it is: Timeshift has a
> pre-selected checkbox "enable BTRFS qgroups (recommended)" [translated
> from German].

Since I've never used qgroups myself, I'll only comment on the parts where I can. 
However, I would say "(recommended)" just to get an estimate of space consumption
is a rather hard label for the option in Timeshift. 

You can check the known issues on qgroups:
https://btrfs.wiki.kernel.org/index.php/Quota_support#Known_issues
This contains, amongst other things, the observed performance issues and also:
"- After deleting a subvolume, you must manually delete the associated qgroup."
which you observe, too. But it does indeed seem btrbk can help out here:
https://github.com/digint/btrbk/issues/49

Manpages of btrfs-quota and btrfs-qgroup contain quite some warnings about the existence
of these known issues, the status page at:
https://btrfs.wiki.kernel.org/index.php/Status
links them, etc. So I believe the recommendation by Timeshift is somewhat hefty. 
Other downstreams (see e.g. https://wiki.debian.org/Btrfs or https://wiki.archlinux.org/index.php/Btrfs#Quota ) 
explicitly recommend not to use qgroup unless really needed. 

Apparently this has also been raised to the developer:
https://github.com/teejee2008/timeshift/issues/127
which has at least led to the addition of the checkmark to allow not enabling qgroup. 

> 2) I'm wondering if this couldn't be improved. Considering qgroups are
> only used (in this case) for reporting on allocated space, not
> limiting it, and btrfs free space reporting is notoriously lazy [not
> meant in a bad way, can't think of a better word right now] anyway,
> why does anything need to block at all? Even if I were using quotas, I
> might prefer fuzzy quotas [that can be be hit too early/late because
> accounting is catching up] to a temporary standstill, as an option.

You can check e.g. the man page btrfs-quota(8) for a short discussion on why doing quota correctly
with btrfs is not as easy as it may seem. 
I'll leave more comments (and how to disable them safely) to those who have experience with qgroups ;-). 

>> Another interesting test could be to adjust btrbk configuration to:
>> btrfs_commit_delete = each
> 
> Will do.
...
> Hm. No freeze, this time (with btrbk set to commit after each delete).

That might be a red herring if there was just less to delete, as Marc Joliet pointed out,
at least, I think this means we identified the reason for the freezes you get. 

Cheers,
	Oliver
