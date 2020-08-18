Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051A4247B64
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 02:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRAKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 20:10:15 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:47198
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgHRAKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 20:10:13 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1k7pCd-00049E-7w
        for linux-btrfs@vger.kernel.org; Tue, 18 Aug 2020 02:10:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Andrew Skretvedt <andrew.skretvedt@gmail.com>
Subject: Re: compress-force mount option documentation is ambiguous
Date:   Mon, 17 Aug 2020 19:10:05 -0500
Message-ID: <rhf68u$f5l$1@ciao.gmane.io>
References: <CAGP+SyZctwxGV=O4vw6pLY-R9LmirNgk=s8Zq9x5juV+3EjMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAGP+SyZctwxGV=O4vw6pLY-R9LmirNgk=s8Zq9x5juV+3EjMEw@mail.gmail.com>
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/17/20 3:18 PM, Peter Kese wrote:
> The `compress-force` mount  option which states:
> 
> "If compress-force is specified, then compression will always be
> attempted, but the data may end up uncompressed if the compression
> would make them larger."
> 

Meanwhile, on my system (Linux Mint 18.3 Sylvia (tracks Ubuntu Xenial)),
the manpage for `mount` (July 2014 - util-linux 2.27.1), in the section
on btrfs-specific mount options says:

> If  compress-force  is specified,  all  files  will  be compressed,
> whether or not they compress well.  If compression is enabled,
> nodatacow and nodata‐ sum are disabled.

While experience suggests to me I shouldn't necessarily consider `man 8
mount` authoritative for every filesystem supported, the reality that
inexperienced users will consult it for authoritative advice suggests
that every effort must be made to keep its information in-sync with
documentation published elsewhere. Alternatively, it's specific
authoritativeness could be called out and then refer the user to where
the most current details can be found, e.g. `man 5 btrfs`. This is kinda
done already, as `man 8 mount` does say, immediately under its
FILESYSTEM-SPECIFIC MOUNT OPTIONS header:

> What options are supported depends a bit on the running  kernel.
> More info  may  be  found  in  the  kernel  source  subdirectory
> Documentation/filesystems.

as a catch-all. *shrug*

-- 
OpenPGP 0xC6901B2A6C976BB3 (https://keys.openpgp.org)

