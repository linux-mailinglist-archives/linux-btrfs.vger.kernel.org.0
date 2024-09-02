Return-Path: <linux-btrfs+bounces-7749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7B968F2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AF9283D3E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB020FA82;
	Mon,  2 Sep 2024 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzhoRV1o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6KvwLjX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DwutmEo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNoqK5SW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BA1A4E8D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725313099; cv=none; b=F0IejZSvOkWLQfwysImbxPaprizsTFqTauEYtnyCN4H5kElrBmPcpBhPSgBifsk9ZSrnSak79pnC79Eicji689oo4PGNkldAEcdKeSH4FkbSQK18LclfvHYCb9rJLr4vnDS511aBZG7cuHEByo4h0ihtg+520x8PoArXkUaVxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725313099; c=relaxed/simple;
	bh=oai8wa09TSUULCbdJeDPBYYKH3feZ21PqGnA1H7ngX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeppaUrb0JvAqLN+coQ8DdNJ1Dmaaw1lcCJKdZWUs+HTQbQqbaQ4la3W5UCg0FEdL8qUog63vZUy8zte9wemYL5NiNMiS5TBaVJ4gLJjuRQf8S5UFygcJNkn/ZTX5lBkl0d/vwXpvmZKk2eqQnpLYw5n56aOSihC5V/M5qOKEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzhoRV1o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6KvwLjX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DwutmEo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNoqK5SW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2CFA218E4;
	Mon,  2 Sep 2024 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725313096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1athTkOqBegD9G3nwG2kxD0Ql/9QdNqHKUuGyk/56k=;
	b=GzhoRV1onnNV5o0xn/7a0nKmokCJsOvXRCkYhzHmS/dWya7nCebljBhUmNDlPuWMOxQluo
	d7mljubBij4XWb6Ye/8hMZF0tZc+N7ue1VAFUk/a5jIv9OGuXxSJZcqGbbOcmFcAcykCV7
	Bmk+KJtxU0FPGdns9vqqmFir0yFvJUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725313096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1athTkOqBegD9G3nwG2kxD0Ql/9QdNqHKUuGyk/56k=;
	b=D6KvwLjXQCiviA7ryhgwEvfcVqwcBjNGdsaze/2z0p3DodnI1W/31g77nG7mGN7vuXG0h3
	aQPR6/pH3foaGQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725313095;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1athTkOqBegD9G3nwG2kxD0Ql/9QdNqHKUuGyk/56k=;
	b=2DwutmEomLtPciIbb95TgjJnbnjeVaKlyZji0vZesaCJ6/+0lu58kex9fNZ3jOsRBfuxA5
	6+DoSsjo9yPeayNY0sO7yZj8hlxamEVnKoDcU4EMaphwK5lKMhX/iEByBs0yuU6F4nx43x
	csxv1j5BKKomfH/OzOeeiVTKhRwRySs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725313095;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1athTkOqBegD9G3nwG2kxD0Ql/9QdNqHKUuGyk/56k=;
	b=bNoqK5SWAY07lRKbYXIPg5AiqXjaoKo/BcVuS3v+MUfNmfswvCiRWa31RO3NlFwj9ic8Td
	dr5T1iEMEI4ykrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E241398F;
	Mon,  2 Sep 2024 21:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7OlnLEcw1mbsKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 21:38:15 +0000
Date: Mon, 2 Sep 2024 23:38:10 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: fix race between direct IO write and fsync
 when using same fd
Message-ID: <20240902213810.GE26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724972506.git.fdmanana@suse.com>
 <717029440fe379747b9548a9c91eb7801bc5a813.1724972507.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717029440fe379747b9548a9c91eb7801bc5a813.1724972507.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 30, 2024 at 12:09:36AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have 2 threads that are using the same file descriptor and one of
> them is doing direct IO writes while the other is doing fsync, we have a
> race where we can end up either:
> 
> 1) Attempt a fsync without holding the inode's lock, triggering an
>    assertion failures when assertions are enabled;
> 
> 2) Do an invalid memory access from the fsync task because the file private
>    points to memory allocated on stack by the direct IO task.
> 
> The race happens like this:
> 
> 1) A user space program opens a file descriptor with O_DIRECT;
> 
> 2) The program spawns 2 threads using libpthread for example;
> 
> 3) One of the threads uses the file descriptor to do direct IO writes,
>    while the other calls fsync using the same file descriptor.
> 
> 4) Call task A the thread doing direct IO writes and task B the thread
>    doing fsyncs;
> 
> 5) Task A does a direct IO write, and at btrfs_direct_write() sets the
>    file's private to an on stack allocated private with the member
>    'fsync_skip_inode_lock' set to true;
> 
> 6) Task B enters btrfs_sync_file() and sees that there's a private
>    structure associated to the file which has 'fsync_skip_inode_lock' set
>    to true, so it skips locking the inode's vfs lock;
> 
> 7) Task completes the direct IO write, and resets the file's private to
>    NULL since it had prior private and our private was stack allocated.
>    Then it unlocks the inode's vfs lock;
> 
> 8) Task B enters btrfs_get_ordered_extents_for_logging(), then the
>    assertion that checks the inode's vfs lock is held fails, since task B
>    never locked it and task A has already unlocked it.
> 
> The stack trace produced is the following:
> 
>    Aug 21 11:46:43 kerberos kernel: assertion failed: inode_is_locked(&inode->vfs_inode), in fs/btrfs/ordered-data.c:983
>    Aug 21 11:46:43 kerberos kernel: ------------[ cut here ]------------
>    Aug 21 11:46:43 kerberos kernel: kernel BUG at fs/btrfs/ordered-data.c:983!
>    Aug 21 11:46:43 kerberos kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
>    Aug 21 11:46:43 kerberos kernel: CPU: 9 PID: 5072 Comm: worker Tainted: G     U     OE      6.10.5-1-default #1 openSUSE Tumbleweed 69f48d427608e1c09e60ea24c6c55e2ca1b049e8
>    Aug 21 11:46:43 kerberos kernel: Hardware name: Acer Predator PH315-52/Covini_CFS, BIOS V1.12 07/28/2020
>    Aug 21 11:46:43 kerberos kernel: RIP: 0010:btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs]
>    Aug 21 11:46:43 kerberos kernel: Code: 50 d6 86 c0 e8 (...)
>    Aug 21 11:46:43 kerberos kernel: RSP: 0018:ffff9e4a03dcfc78 EFLAGS: 00010246
>    Aug 21 11:46:43 kerberos kernel: RAX: 0000000000000054 RBX: ffff9078a9868e98 RCX: 0000000000000000
>    Aug 21 11:46:43 kerberos kernel: RDX: 0000000000000000 RSI: ffff907dce4a7800 RDI: ffff907dce4a7800
>    Aug 21 11:46:43 kerberos kernel: RBP: ffff907805518800 R08: 0000000000000000 R09: ffff9e4a03dcfb38
>    Aug 21 11:46:43 kerberos kernel: R10: ffff9e4a03dcfb30 R11: 0000000000000003 R12: ffff907684ae7800
>    Aug 21 11:46:43 kerberos kernel: R13: 0000000000000001 R14: ffff90774646b600 R15: 0000000000000000
>    Aug 21 11:46:43 kerberos kernel: FS:  00007f04b96006c0(0000) GS:ffff907dce480000(0000) knlGS:0000000000000000
>    Aug 21 11:46:43 kerberos kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    Aug 21 11:46:43 kerberos kernel: CR2: 00007f32acbfc000 CR3: 00000001fd4fa005 CR4: 00000000003726f0
>    Aug 21 11:46:43 kerberos kernel: Call Trace:
>    Aug 21 11:46:43 kerberos kernel:  <TASK>
>    Aug 21 11:46:43 kerberos kernel:  ? __die_body.cold+0x14/0x24
>    Aug 21 11:46:43 kerberos kernel:  ? die+0x2e/0x50
>    Aug 21 11:46:43 kerberos kernel:  ? do_trap+0xca/0x110
>    Aug 21 11:46:43 kerberos kernel:  ? do_error_trap+0x6a/0x90
>    Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
>    Aug 21 11:46:43 kerberos kernel:  ? exc_invalid_op+0x50/0x70
>    Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
>    Aug 21 11:46:43 kerberos kernel:  ? asm_exc_invalid_op+0x1a/0x20
>    Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
>    Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
>    Aug 21 11:46:43 kerberos kernel:  btrfs_sync_file+0x21a/0x4d0 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
>    Aug 21 11:46:43 kerberos kernel:  ? __seccomp_filter+0x31d/0x4f0
>    Aug 21 11:46:43 kerberos kernel:  __x64_sys_fdatasync+0x4f/0x90
>    Aug 21 11:46:43 kerberos kernel:  do_syscall_64+0x82/0x160
>    Aug 21 11:46:43 kerberos kernel:  ? do_futex+0xcb/0x190
>    Aug 21 11:46:43 kerberos kernel:  ? __x64_sys_futex+0x10e/0x1d0
>    Aug 21 11:46:43 kerberos kernel:  ? switch_fpu_return+0x4f/0xd0
>    Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
>    Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
>    Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
>    Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
>    Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
>    Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
>    Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
>    Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
>    Aug 21 11:46:43 kerberos kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Another problem here is if task B grabs the private pointer and then uses
> it after task A has finished, since the private was allocated in the stack
> of trask A, resulting in some invalid memory access with a hard to predict
> result.
> 
> This issue, triggering the assertion, was observed with QEMU workloads by
> two users in the Link tags below.
> 
> Fix this by not relying on a file's private to pass information to fsync
> that it should skip locking the inode and instead pass this information
> through a special value stored in current->journal_info. This is safe
> because in the relevant section of the direct IO write path we are not
> holding a transaction handle, so current->journal_info is NULL.
> 
> The following C program triggers the issue:
> 
>    $ cat repro.c
>    /* Get the O_DIRECT definition. */
>    #ifndef _GNU_SOURCE
>    #define _GNU_SOURCE
>    #endif
> 
>    #include <stdio.h>
>    #include <stdlib.h>
>    #include <unistd.h>
>    #include <stdint.h>
>    #include <fcntl.h>
>    #include <errno.h>
>    #include <string.h>
>    #include <pthread.h>
> 
>    static int fd;
> 
>    static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
>    {
>        while (count > 0) {
>            ssize_t ret;
> 
>            ret = pwrite(fd, buf, count, offset);
>            if (ret < 0) {
>                if (errno == EINTR)
>                    continue;
>                return ret;
>            }
>            count -= ret;
>            buf += ret;
>        }
>        return 0;
>    }
> 
>    static void *fsync_loop(void *arg)
>    {
>        while (1) {
>            int ret;
> 
>            ret = fsync(fd);
>            if (ret != 0) {
>                perror("Fsync failed");
>                exit(6);
>            }
>        }
>    }
> 
>    int main(int argc, char *argv[])
>    {
>        long pagesize;
>        void *write_buf;
>        pthread_t fsyncer;
>        int ret;
> 
>        if (argc != 2) {
>            fprintf(stderr, "Use: %s <file path>\n", argv[0]);
>            return 1;
>        }
> 
>        fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
>        if (fd == -1) {
>            perror("Failed to open/create file");
>            return 1;
>        }
> 
>        pagesize = sysconf(_SC_PAGE_SIZE);
>        if (pagesize == -1) {
>            perror("Failed to get page size");
>            return 2;
>        }
> 
>        ret = posix_memalign(&write_buf, pagesize, pagesize);
>        if (ret) {
>            perror("Failed to allocate buffer");
>            return 3;
>        }
> 
>        ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
>        if (ret != 0) {
>            fprintf(stderr, "Failed to create writer thread: %d\n", ret);
>            return 4;
>        }
> 
>        while (1) {
>            ret = do_write(fd, write_buf, pagesize, 0);
>            if (ret != 0) {
>                perror("Write failed");
>                exit(5);
>            }
>        }
> 
>        return 0;
>    }
> 
>    $ mkfs.btrfs -f /dev/sdi
>    $ mount /dev/sdi /mnt/sdi
>    $ timeout 10 ./repro /mnt/sdi/foo
> 
> Usually the race is triggered within less than 1 second. A test case for
> fstests will follow soon.
> 
> Reported-by: Paulo Dias <paulo.miguel.dias@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219187
> Reported-by: Andreas Jahn <jahn-andi@web.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219199
> Reported-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000044ff540620d7dee2@google.com/
> Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

