Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E011C341B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEDINe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 04:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEDINd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 04:13:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9DAF2AED5;
        Mon,  4 May 2020 08:13:33 +0000 (UTC)
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com>
Date:   Mon, 4 May 2020 11:13:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.05.20 г. 11:03 ч., Chris Murphy wrote:
> receive (rw,noatime,seclabel,compress-force=zstd:5,space_cache=v2,subvolid=5,subvol=/)
> send    (rw,noatime,seclabel,compress=zstd:1,nossd,notreelog,space_cache=v2,subvolid=5,subvol=/)
> 
> Both are on dm-crypt.
> 
> perf top -g -U consumes about 85% CPU according to top, and every time
> I run it, the btrfs send performance *increases*. When I cancel this
> perf top command, it returns to the slower performance. Curious.
> 

Well this still doesn't show the stack traces, after all the + sign
means you can expand that (with the 'e' key). But looking at this I
don't see any particular lock contention - just compression-related
functions.

> Samples
>   Children      Self  Shared Object        Symbol
> +   40.56%     0.09%  [kernel]             [k] entry_SYSCALL_64_after_hwframe
> +   40.30%     0.07%  [kernel]             [k] do_syscall_64
> +   27.88%     0.00%  [kernel]             [k] ret_from_fork
> +   27.88%     0.00%  [kernel]             [k] kthread
> +   27.20%     0.02%  [kernel]             [k] process_one_work
> +   25.69%     0.01%  [kernel]             [k] worker_thread
> +   22.05%     0.01%  [kernel]             [k] btrfs_work_helper
> +   19.01%     0.01%  [kernel]             [k] __x64_sys_splice
> +   18.98%     2.02%  [kernel]             [k] do_splice
> +   14.70%     0.00%  [kernel]             [k] async_cow_start
> +   14.70%     0.00%  [kernel]             [k] compress_file_range
> +   14.40%     0.00%  [kernel]             [k] temp_notif.12+0x4
> +   13.20%     0.00%  [kernel]             [k] ZSTD_compressContinue_internal
> +   13.14%     0.00%  [kernel]             [k] garp_protos+0x35
> +   12.99%     0.01%  [kernel]             [k] nft_request_module
> +   12.95%     0.01%  [kernel]             [k] ZSTD_compressStream
> +   11.95%     0.01%  [kernel]             [k] ksys_read
> +   11.87%     0.02%  [kernel]             [k] vfs_read
> +   11.76%    11.45%  [kernel]             [k] fuse_perform_write
> +   11.26%     0.02%  [kernel]             [k] do_idle
> +   10.80%     0.01%  [kernel]             [k] cpuidle_enter
> +   10.79%     0.01%  [kernel]             [k] cpuidle_enter_state
> +   10.54%    10.54%  [kernel]             [k] mwait_idle_with_hints.constprop.0
> +   10.33%     0.00%  libc-2.31.so         [.] splice
> +    7.93%     7.59%  [kernel]             [k] mutex_unlock
> +    7.38%     0.01%  [kernel]             [k] new_sync_read
> +    7.36%     0.10%  [kernel]             [k] pipe_read
> +    6.46%     0.07%  [kernel]             [k] __mutex_lock.constprop.0
> +    6.34%     6.23%  [kernel]             [k] mutex_spin_on_owner
> +    6.20%     0.00%  [kernel]             [k] secondary_startup_64
> +    6.20%     0.00%  [kernel]             [k] cpu_startup_entry
> +    6.05%     3.89%  [kernel]             [k] mutex_lock
> +    5.78%     0.00%  [kernel]             [k] intel_idle
> +    5.53%     0.00%  [kernel]             [k] iwl_mvm_mac_conf_tx
> +    5.43%     0.00%  [kernel]             [k] run_one_async_start
> +    5.43%     0.00%  [kernel]             [k] btrfs_submit_bio_start
> +    5.31%     0.06%  [kernel]             [k] blake2b_update
> +    5.11%     1.39%  [kernel]             [k] pipe_double_lock
> +    4.28%     0.01%  [kernel]             [k] proc_reg_read
> +    4.27%     0.09%  [kernel]             [k] seq_read
> For a higher level overview, try: perf top --sort comm,dso
> 
