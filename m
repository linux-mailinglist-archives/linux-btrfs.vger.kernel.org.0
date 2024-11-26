Return-Path: <linux-btrfs+bounces-9918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D189D9B18
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8209F166DBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D11D63D6;
	Tue, 26 Nov 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuwiFqlY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0753EA69
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637505; cv=none; b=hLVyX+ZJdYdGCg1wjc423gGE49+yFqIvaDDkQUxmUB+vf3uUajbYbwrM7vzmhKtB3yo4aDkLm8UNhSCP39F+FhWDcf1nwKZhXjvNhlrxpRwZhzXBe6ZuQogg0aiJh7CPeUT6X7ep64j9n+cQIPliuy9+3n7mqD6+iPdWQlfsv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637505; c=relaxed/simple;
	bh=Yd1WLiytjwSarNtHToC/ZuKD+DU6/lBpipaE70bemdY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tZv13gvpvQR7AqQAPuor1bXjz+CFZT6o3KwKGRcOj/GjqBPp3MubXGTh+4UxRquhHbNfqLNIUzOy1mS/j0XiGFHUVkscAainnHSHOFKsKYwU47aZumu8zUgfZp+wlQP6R5qFLyXrIC6rBnUxSxiry+uXSpDLtDF3JNiZESYKJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuwiFqlY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53def60f942so246107e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732637501; x=1733242301; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gRodeU7dbLbrHw0x8w0JMKTSigMa1weRSqJEGntjhx8=;
        b=KuwiFqlYqc89BP9NcuS9nAuSIgnK+fjnfgdLEYa4hRzDWjGTKSlFKlae0innUid2m+
         9rh7v/OcZCp6I2gWkvCItNp79BBWpNzHIEybqTZHWhz6AbhZTgw+ZjKGCOXWhP+YzlvS
         sy342cGYdG4UElBv4cHOXHPMxT3BmdC4RflWbUrnBhUgvnAhMAWMhPSIBS5wfTNrrCN8
         wv6oG0enGAu+zN59pjvB8hY7GhaIjkru9R7eYSpFozJT9B3RgH7KSvLQXLy4kqgWOzSv
         VE+8T8ALz+oQy+dLlvS4tFKEvEsdhEi3JbQuKvGcqf7xNDXKVUP3kIP6/CKGcREgMyTi
         10pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732637501; x=1733242301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRodeU7dbLbrHw0x8w0JMKTSigMa1weRSqJEGntjhx8=;
        b=H82YVnD4YafDo2Tj3jE2Nv8vkyr+WMCK60AVyK84pB6pBS7PhOUQn1X818SG18Sz5C
         U3f4Xp8OTZV1a1Fa9jOTjleUtD16uaXfzqBdMb9zVZWoKcPthNp1SVGqjoZfxXopw47z
         HD6k9wYZxVZ623trIL/ZNcnFuGykKwWZg27HFJVLUpSbscBg0qmbT27ZU6tKunobfJEM
         o7QAFrYBfP6uoigdw9hzJeqwX/8KjtI7MgnCCM48KEyEQAXJxEnnsNvKwvmBLH3zLYAz
         /I4QHY7AQpVsO2XGczGHFJ+pPw9n5YZUpvCHTdZGxeqXyb4ofv3K/23M9BU8dUJLR01V
         RW/w==
X-Gm-Message-State: AOJu0YyJA0XjwoFUuz1KCq8bNxc7ilRFgEcO6JJ/UQfXMNpdvQyR/agw
	nAjdf0DxONTOFjbuFAw+JIpK0VR6RQlLMHaxjtUycVP/dqYdr0ee/LppAMu2PEPDTyAfeg3jSKM
	OljwepfBbQ7am31wRXsvOxY5JQfDQ63SV
X-Gm-Gg: ASbGncuXyqVCg9l/w9e+yT3oYtnnVcbDenV6fcx02ZeL97RlkRbKmjqeSyfTCtz6lBq
	/zhFtrxsyqO8paCVwk+Eg6aJ1CvLZK38=
X-Google-Smtp-Source: AGHT+IFLs/V4rTVEoDsHy2BQ3RABpS4E50TBtm2j2rJIYh807Y4n2y26Xp8tDnHr/M46cfD/SymFzmq+iTd0HaH59Lo=
X-Received: by 2002:a05:6512:3c8c:b0:53d:db99:c79e with SMTP id
 2adb3069b0e04-53ddb99e8cdmr7095987e87.3.1732637501046; Tue, 26 Nov 2024
 08:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brett Dikeman <brett.dikeman@gmail.com>
Date: Tue, 26 Nov 2024 11:11:29 -0500
Message-ID: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
Subject: corrupt leaf, invalid data ref objectid value, read time tree block
 corruption detected Inbox
To: linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c661fd0627d31af9"

--000000000000c661fd0627d31af9
Content-Type: text/plain; charset="UTF-8"

Greetings,

I have a filesystem that re-mounted read-only very shortly after I
started a btrfs defrag with zst compression enabled (which is not to
say I think this was the cause.) The volume  resides on a Debian
Bookworm system and is very simple configuration/feature-wise; it does
not use quotas, snapshots, or sub-volumes. In the few hours prior to
running the defrag command, I deleted a large number of files that
totaled about 100GB of space. Prior to that, the filesystem hasn't
seen changes in months; even atimes are disabled.

btrfs check completes with no errors generated in dmesg or the
terminal during the check, it takes what seems like a reasonable
amount of time with not much interruption in disk activity. A scrub
progresses at expected speeds but suddenly stops with a status of
"success" after a few GB.). There are no signs of drive failure from
SMART parameters, and no kernel messages that would suggest drive
failure, such as timeouts or SATA errors. However, I am currently
running a nondestructive-write badblocks test to address this
possibility a bit more - both drives have made it  in to 10% so far,
with no errors in dmesg or badblocks.

What I have tried:

- upgraded btrfsprogs to bookworm-backports because bookworm's
btrfsprogs is old enough that it doesn't include several rescue
commands.
- clearing the zero log
- clearing the inode cache
- clearing the space cache.

It was mounting OK until around when I updated the tools package and
ran some of the above commands. During one attempt to run a scrub,
there was dmesg output I unfortunately did not catch, but I remember
something that looked similar to what I've seen when I had md array
that ended up with different-aged metadata when one drive was booted
out of a 4-drive array; I had to force md to ignore its timestamp.

Any recommendations on how to proceed would be greatly appreciated.
dmesg output is included as an attachment.

uname -a output:
6.11.5+bpo-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.11.5-1~bpo12+1
(2024-11-11) x86_64 GNU/Linux

btrfs version:
btrfs-progs v6.6.3

#  btrfs fi show
Label: none  uuid: b1e76acd-525d-46f2-b2a6-b0403dcdc135
Total devices 2 FS bytes used 1.37TiB
devid    1 size 1.82TiB used 1.44TiB path /dev/sdd
devid    2 size 1.82TiB used 1.44TiB path /dev/sdc

--000000000000c661fd0627d31af9
Content-Type: text/plain; charset="US-ASCII"; name="dmesg-11-25-2024.txt"
Content-Disposition: attachment; filename="dmesg-11-25-2024.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m3yn7i990>
X-Attachment-Id: f_m3yn7i990

W01vbiBOb3YgMjUgMTY6MjI6MDYgMjAyNF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6IGZpcnN0
IG1vdW50IG9mIGZpbGVzeXN0ZW0gYjFlNzZhY2QtNTI1ZC00NmYyLWIyYTYtYjA0MDNkY2RjMTM1
CltNb24gTm92IDI1IDE2OjIyOjA2IDIwMjRdIEJUUkZTIGluZm8gKGRldmljZSBzZGQpOiB1c2lu
ZyBjcmMzMmMgKGNyYzMyYy1pbnRlbCkgY2hlY2tzdW0gYWxnb3JpdGhtCltNb24gTm92IDI1IDE2
OjIyOjA2IDIwMjRdIEJUUkZTIGluZm8gKGRldmljZSBzZGQpOiB1c2luZyBmcmVlLXNwYWNlLXRy
ZWUKW01vbiBOb3YgMjUgMTY6MjI6MTAgMjAyNF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6IGNy
ZWF0aW5nIGZyZWUgc3BhY2UgdHJlZQpbTW9uIE5vdiAyNSAxNjoyMjoxOSAyMDI0XSBwYWdlOiBy
ZWZjb3VudDo0IG1hcGNvdW50OjAgbWFwcGluZzowMDAwMDAwMDllZTVhYWRlIGluZGV4OjB4MmQy
NTEwOWIgcGZuOjB4M2IzMjJmCltNb24gTm92IDI1IDE2OjIyOjE5IDIwMjRdIG1lbWNnOmZmZmY5
ZDZkYWViMjA4MDAKW01vbiBOb3YgMjUgMTY6MjI6MTkgMjAyNF0gYW9wczpidHJlZV9hb3BzIFti
dHJmc10gaW5vOjEKW01vbiBOb3YgMjUgMTY6MjI6MTkgMjAyNF0gZmxhZ3M6IDB4MTdmZmZmYzAw
MDQwMDAocHJpdmF0ZXxub2RlPTB8em9uZT0yfGxhc3RjcHVwaWQ9MHgxZmZmZmYpCltNb24gTm92
IDI1IDE2OjIyOjE5IDIwMjRdIHJhdzogMDAxN2ZmZmZjMDAwNDAwMCAwMDAwMDAwMDAwMDAwMDAw
IGRlYWQwMDAwMDAwMDAxMjIgZmZmZjlkNmY1OGE5NGVmOApbTW9uIE5vdiAyNSAxNjoyMjoxOSAy
MDI0XSByYXc6IDAwMDAwMDAwMmQyNTEwOWIgZmZmZjlkNmYxYzExMTRhMCAwMDAwMDAwNGZmZmZm
ZmZmIGZmZmY5ZDZkYWViMjA4MDAKW01vbiBOb3YgMjUgMTY6MjI6MTkgMjAyNF0gcGFnZSBkdW1w
ZWQgYmVjYXVzZTogZWIgcGFnZSBkdW1wCltNb24gTm92IDI1IDE2OjIyOjE5IDIwMjRdIEJUUkZT
IGNyaXRpY2FsIChkZXZpY2Ugc2RkKTogY29ycnVwdCBsZWFmOiBibG9jaz0zMTAyMzI1OTc3MDg4
IHNsb3Q9MTIgZXh0ZW50IGJ5dGVucj02NzgxNzc5OTY4IGxlbj0xMzkyNjQgaW52YWxpZCBkYXRh
IHJlZiBvYmplY3RpZCB2YWx1ZSAxODQ0Njc0NDA3MzcwOTU1MTYwNApbTW9uIE5vdiAyNSAxNjoy
MjoxOSAyMDI0XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHJlYWQgdGltZSB0cmVlIGJsb2Nr
IGNvcnJ1cHRpb24gZGV0ZWN0ZWQgb24gbG9naWNhbCAzMTAyMzI1OTc3MDg4IG1pcnJvciAyCltN
b24gTm92IDI1IDE2OjIyOjE5IDIwMjRdIHBhZ2U6IHJlZmNvdW50OjMgbWFwY291bnQ6MCBtYXBw
aW5nOjAwMDAwMDAwOWVlNWFhZGUgaW5kZXg6MHgyZDI1MTA5YiBwZm46MHgzYjMyMmYKW01vbiBO
b3YgMjUgMTY6MjI6MTkgMjAyNF0gbWVtY2c6ZmZmZjlkNmRhZWIyMDgwMApbTW9uIE5vdiAyNSAx
NjoyMjoxOSAyMDI0XSBhb3BzOmJ0cmVlX2FvcHMgW2J0cmZzXSBpbm86MQpbTW9uIE5vdiAyNSAx
NjoyMjoxOSAyMDI0XSBmbGFnczogMHgxN2ZmZmZkMDAwNDAyMChscnV8cHJpdmF0ZXxub2RlPTB8
em9uZT0yfGxhc3RjcHVwaWQ9MHgxZmZmZmYpCltNb24gTm92IDI1IDE2OjIyOjE5IDIwMjRdIHJh
dzogMDAxN2ZmZmZkMDAwNDAyMCBmZmZmZTY0ODhkMTY5YzA4IGZmZmY5ZDZkYWViMjEyMTAgZmZm
ZjlkNmY1OGE5NGVmOApbTW9uIE5vdiAyNSAxNjoyMjoxOSAyMDI0XSByYXc6IDAwMDAwMDAwMmQy
NTEwOWIgZmZmZjlkNmYxYzExMTRhMCAwMDAwMDAwM2ZmZmZmZmZmIGZmZmY5ZDZkYWViMjA4MDAK
W01vbiBOb3YgMjUgMTY6MjI6MTkgMjAyNF0gcGFnZSBkdW1wZWQgYmVjYXVzZTogZWIgcGFnZSBk
dW1wCltNb24gTm92IDI1IDE2OjIyOjE5IDIwMjRdIEJUUkZTIGNyaXRpY2FsIChkZXZpY2Ugc2Rk
KTogY29ycnVwdCBsZWFmOiBibG9jaz0zMTAyMzI1OTc3MDg4IHNsb3Q9MTIgZXh0ZW50IGJ5dGVu
cj02NzgxNzc5OTY4IGxlbj0xMzkyNjQgaW52YWxpZCBkYXRhIHJlZiBvYmplY3RpZCB2YWx1ZSAx
ODQ0Njc0NDA3MzcwOTU1MTYwNApbTW9uIE5vdiAyNSAxNjoyMjoxOSAyMDI0XSBCVFJGUyBlcnJv
ciAoZGV2aWNlIHNkZCk6IHJlYWQgdGltZSB0cmVlIGJsb2NrIGNvcnJ1cHRpb24gZGV0ZWN0ZWQg
b24gbG9naWNhbCAzMTAyMzI1OTc3MDg4IG1pcnJvciAxCltNb24gTm92IDI1IDE2OjIyOjE5IDIw
MjRdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkIHN0YXRlIEEpOiBUcmFuc2FjdGlvbiBhYm9ydGVk
IChlcnJvciAtNSkKW01vbiBOb3YgMjUgMTY6MjI6MTkgMjAyNF0gQlRSRlM6IGVycm9yIChkZXZp
Y2Ugc2RkIHN0YXRlIEEpIGluIGJ0cmZzX2NyZWF0ZV9mcmVlX3NwYWNlX3RyZWU6MTE5NzogZXJy
bm89LTUgSU8gZmFpbHVyZQpbTW9uIE5vdiAyNSAxNjoyMjoxOSAyMDI0XSBCVFJGUyB3YXJuaW5n
IChkZXZpY2Ugc2RkIHN0YXRlIEVBKTogZmFpbGVkIHRvIGNyZWF0ZSBmcmVlIHNwYWNlIHRyZWU6
IC01CltNb24gTm92IDI1IDE2OjIyOjE5IDIwMjRdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkIHN0
YXRlIEVBKTogY29tbWl0IHN1cGVyIHJldCAtMzAKW01vbiBOb3YgMjUgMTY6MjI6MTkgMjAyNF0g
QlRSRlMgZXJyb3IgKGRldmljZSBzZGQgc3RhdGUgRUEpOiBvcGVuX2N0cmVlIGZhaWxlZA==
--000000000000c661fd0627d31af9--

