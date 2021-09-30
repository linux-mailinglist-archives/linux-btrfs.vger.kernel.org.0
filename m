Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE241DC23
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 16:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbhI3OVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 10:21:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:55811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240149AbhI3OVB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 10:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633011555;
        bh=edNdxj+38vq3gShlGQfSWvNpmlhc73mzeNqriBewNng=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=LDw4jnijgsblasO5+iM4gMZxTEBu2rbDTchrGqKkPFR6stGECiCYnv/rHclIPPW4w
         47IHTj0WGNBsu1WUSLMiNIgjgLEJjNd7n+HEQnA3nzmcs0tpp5n/wyxnT3wN8h+F43
         YHf1ZzZsr2sfKCqoysQyYU/mRYy50hvjmFKFzj0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1mRZBq2Vm4-004WIF; Thu, 30
 Sep 2021 16:19:15 +0200
Message-ID: <a53fedc0-c1f6-4024-8fbb-c030d8f083a1@gmx.com>
Date:   Thu, 30 Sep 2021 22:19:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Graham Cobb <g.btrfs@cobb.uk.net>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210930114855.39225-1-wqu@suse.com>
 <20210930114855.39225-2-wqu@suse.com>
 <933152a1-e37e-192c-734b-77f5f1735c8b@cobb.uk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 1/2] btrfs-progs: receive: fallback to buffered copy if
 clone failed
In-Reply-To: <933152a1-e37e-192c-734b-77f5f1735c8b@cobb.uk.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Ih+F8NSNo+T8M/NNYXo1TR6viVpXJpaF/6NuLHyLqJlXVCvzvI
 xwrq/FWsg+goz+4EqGgzpKYySyA0B7lzCyUVqIXj12OXQ2/VDR7qSDniwYeKd5nytCU+gNj
 f7ppTHaVXeFtCrc8BO2f3/WUjd9xsrAE1cEEQkh3u9kSrO9x7/ERBLm3GSCjj8Fzm7/1Qho
 9vtHwt+4NcS4/OoulX2fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dr3nMYKeoaU=:OvGZeCOajxPo3YalgLqPRo
 ts2FHiSWqxXETczkFE9dvGOBPMGkicKpIxqRVEcZsk83Q4ChokFYqLz29rfKRBHaIHog0A4GV
 4tcmvfcWoXtM5TBvTF40UkHF6GaJKyBQzjhllvnDVwC9aJu53I9di72EGtMpzT9kv5hjkbhl2
 4j9oCzYSHfhzIUySiQc4EafuBxo2FNf8g++c2ag0NAk32/tAhiNmzQIONgA5WKcEj4UE0EmbR
 Zu986MCbN6Z/EFNSGsyywGQqnyKtNyhJCMv+DK98pCa3F7Mja1XWiXFLVN9zO7Yj0SUvLNG0x
 IUME1BagOC4Y/O8eU5hSgtm3fZ/t4LIsSEUB0gzhHdNsL/O+HsbZbp6ITFhvZNMwWNvK/rF5f
 /8gm7S3PdHZVU8gl9SGUJWmyq2V7FegGxVcQ1YArRCl8ubWDhV5jwYTemYRhknFrjczpAywKl
 C2nvKaFa+XtDjhnpImjNgt1Qcd3WsdGLs9kZ+uLIYhk/xSR9McxSjC3k4jmjFuYpZRMhJV+jB
 Oc3y7HPeJmxX15/z5EU6dir0pEtzJtYVisWciGKwY+YW79qcrnX+PkRrfedpoOVbUSRHceb2R
 CmoiTs9X9WmdbXEiXJwc1diLGOZJV/9YEhUQtAAY1yFNIp9rYOmPtmSzpEzS6Ggq7B/yWl/c/
 0LqZVcCbV3XeXFq0V9vdimJ5HPmcT/ztrsK3a62t2u0WpBCcvE4yWyGkW5tCA1SE6Drj3xaSX
 bHE64npdb9g/MmW5C/98avVDKbLujlJqVz3KcJ44HkTCSrU+kqV7m7aBwAkrFGgcFGGPHF7UV
 baKS8F8VlNLT0+DG1OnEXajsA4BwyUmT6NNYEtLMHfk1g/l8tX5HyEg4hJEWxS31XoGH7jEbS
 PZ4VMNFGtHb9jaHiypqE+rfXm1TejvYctXSbNDHozTS3GK2MxvxVGmMsO7cyiAEH35HeA2+/K
 TWi26/mPrgj5ywJmY7GmxZPbbPGS1JjL8Wos38bm4rmv10LolJ64e3BnVSReyDuNuXyOa7ZCV
 b/NH5F80egIHXWDLCHdJ5GpNW8ejTUY69pwG4H++wt652aNbjIuVtjrxpdSbRA/wXESR1AIKI
 qdo3+s7byW5AOE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/30 20:47, Graham Cobb wrote:
> On 30/09/2021 12:48, Qu Wenruo wrote:
>> [BUG]
>> There are two very basic send streams:
>> (a/m/ctime and uuid omitted)
>>
>>    Stream 1: (Parent subvolume)
>>    subvol   ./parent_subv           transid=3D8
>>    chown    ./parent_subv/          gid=3D0 uid=3D0
>>    chmod    ./parent_subv/          mode=3D755
>>    utimes   ./parent_subv/
>>    mkfile   ./parent_subv/o257-7-0
>>    rename   ./parent_subv/o257-7-0  dest=3D./parent_subv/source
>>    utimes   ./parent_subv/
>>    write    ./parent_subv/source    offset=3D0 len=3D16384
>>    chown    ./parent_subv/source    gid=3D0 uid=3D0
>>    chmod    ./parent_subv/source    mode=3D600
>>    utimes   ./parent_subv/source
>>
>>    Stream 2: (snapshot and clone)
>>    snapshot ./dest_subv             transid=3D14 parent_transid=3D10
>>    utimes   ./dest_subv/
>>    mkfile   ./dest_subv/o258-14-0
>>    rename   ./dest_subv/o258-14-0   dest=3D./dest_subv/reflink
>>    utimes   ./dest_subv/
>>    clone    ./dest_subv/reflink     offset=3D0 len=3D16384 from=3D./des=
t_subv/source clone_offset=3D0
>>    chown    ./dest_subv/reflink     gid=3D0 uid=3D0
>>    chmod    ./dest_subv/reflink     mode=3D600
>>    utimes   ./dest_subv/reflink
>>
>> But if we receive the first stream with default mount, then remount to
>> nodatasum, and try to receive the second stream, it will fail:
>>
>>   # mount /mnt/btrfs
>>   # btrfs receive -f ~/parent_stream /mnt/btrfs/
>>   At subvol parent_subv
>>   # mount -o remount,nodatasum /mnt/btrfs
>>   # btrfs receive -f ~/clone_stream /mnt/btrfs/
>>   At snapshot dest_subv
>>   ERROR: failed to clone extents to reflink: Invalid argument
>>   # echo $?
>>   1
>>
>> [CAUSE]
>> Btrfs doesn't allow clone source and destination files have different
>> NODATASUM flags.
>> This is to prevent a data extent to be owned by both NODATASUM inode an=
d
>> regular DATASUM inode.
>>
>> For above receive operations, the clone destination is inheriting the
>> NODATASUM flag from mount option, while the clone source has no
>> NODATASUM flag, thus preventing us from doing the clone.
>>
>> [FIX]
>> Btrfs send/receive doesn't require the underlying inode has the same
>> flags (thus we can send from compressed extent and receive on a
>> non-compressed filesystem).
>>
>> So here we add a new command line option, '--clone-fallback', to allow
>> btrfs-receive to fall back to buffered write to copy data from the
>> source file.
>>
>> Since such behavior can result much less clone operations, which may no=
t
>> be what the end users really want, and can hide bugs in send stream.
>> Thus this behavior must be explicitly specified by the new option.
>>
>> And we will output a warning message each time such fallback is
>> triggered if the user wants extra debug output.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-receive.asciidoc | 12 ++++++
>>   cmds/receive.c                       | 62 ++++++++++++++++++++++++++-=
-
>>   2 files changed, 71 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs=
-receive.asciidoc
>> index e4c4d2c0bf3d..9c934a399a9c 100644
>> --- a/Documentation/btrfs-receive.asciidoc
>> +++ b/Documentation/btrfs-receive.asciidoc
>> @@ -65,6 +65,18 @@ dump the stream metadata, one line per operation
>>   +
>>   Does not require the 'path' parameter. The filesystem remains unchang=
ed.
>>
>> +--clone-fallback::
>> +when clone opeartions fail, attempt to directly copy the data instead.
>> ++
>> +When the source and destination filesystems have different sector size=
s, or
>> +when source and destination files have differnt 'nodatacow' and/or 'no=
datasum'
>
> typo: "different"
>
>> +flags (can be set per-file or through mount options), clone operations=
 can fail.
>> ++
>> +This option makes the receive process attempt to manually copy data fr=
om the
>> +source to the destination file when a clone operation fails (caused by=
 above
>> +reasons). When this happens, extents will end up not being shared
>> +between the files, thus will take up more space.
>
> Send/receive and the storage savings available by storing snapshots are
> important btrfs features for many sysadmins.

BTW, the space saving by receiving a snapshot is not affected in this case=
.

As a snapshot is received by doing a snapshot of the target subvolume at
the receiving side.
Thus this particular situation is only affecting clone operations in a
send stream.

> I think the documentation
> needs to be a bit clearer.
>
> 1) It says that the fallback happens when the clone operation fails
> "caused by above reasons". Is that right? Is it **only** those cases
> that can cause EINVAL error?

And the recent RO->RW problems.

Despite those send stream problems, I don't have other obvious reasons yet=
.

> In the earlier email discussion there was
> mention of different compression settings - would that cause a problem?

No.

Send stream only contains the content of the file, not the compressed
content.

For the send stream, there is no difference in the content (all the
uncompressed data).

> What about new features like the VerifyFS stuff being worked on (I have
> no idea - just choosing a work-in-progress item as an example).

If those new features are adding new limitations to reflink, then it
could be.

E.g. if we're going to support encryption, then reflinking from
unencrypted inode to an encrypted inode will fail.

But unfortunately I don't have better description for such feature cases.

> If these
> are the only two cases, I think there needs to be a code comment in the
> kernel code that returns this error that if any other cases are
> introduced the documentation for --clone-fallback needs to be updated.

All the reasons are related to the reflink limitation:

- Sectorsize
   Reflink requires certain alignment

- Btrfs specific flags
   NODATASUM and NODATACOW flags difference between source/destination
   files will reject the reflink

There are some others that could return -EINVAL, like invalid remap flags.
But that's not possible inside btrfs-receive, as we will not use those
invalid flags.

Others are very basic checks, like the source should be a regular file,
the range should not overflow.

If the very basic requirement can't be met, it should be a send bug.
Thankfully we don't have such reports yet, except the ongoing RO->RW->RO
problem.

>
> 2) In any case, "caused by above reasons" sounds a bit unnatural to me
> (native English speaker). I would suggest replacing "(caused by above
> reasons)" with "in this way".

Thanks for the better expressions, I am definitely not the proper guy to
write docs...

>
> 3) And maybe add another sentence: "A warning message will be displayed
> when this happens, if the --verbose option is in effect".
>
>> +
>>   -q|--quiet::
>>   (deprecated) alias for global '-q' option
>>
>> diff --git a/cmds/receive.c b/cmds/receive.c
>> index 48c774cea587..31746d571016 100644
>> --- a/cmds/receive.c
>> +++ b/cmds/receive.c
>> @@ -76,6 +76,8 @@ struct btrfs_receive
>>   	struct subvol_uuid_search sus;
>>
>>   	int honor_end_cmd;
>> +
>> +	bool clone_fallback;
>>   };
>>
>>   static int finish_subvol(struct btrfs_receive *rctx)
>> @@ -705,6 +707,44 @@ out:
>>   	return ret;
>>   }
>>
>> +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 l=
en,
>> +			 u64 dest_offset)
>> +{
>> +	unsigned char buf[SZ_32K];
>> +	u64 copied =3D 0;
>> +	int ret =3D 0;
>> +
>> +	while (copied < len) {
>> +		u32 copy_len =3D min_t(u32, ARRAY_SIZE(buf), len - copied);
>> +		u32 written =3D 0;
>> +		ssize_t read_size;
>> +
>> +		read_size =3D pread(src_fd, buf, copy_len, src_offset + copied);
>> +		if (read < 0) {
>> +			ret =3D -errno;
>> +			error("failed to read source file: %m");
>> +			return ret;
>> +		}
>> +
>> +		/* Write the buffer to dest file */
>> +		while (written < read_size) {
>> +			ssize_t write_size;
>> +
>> +			write_size =3D pwrite(dst_fd, buf + written,
>> +					read_size - written,
>> +					dest_offset + copied + written);
>> +			if (write_size < 0) {
>> +				ret =3D -errno;
>> +				error("failed to write source file: %m");
>> +				return ret;
>> +			}
>> +			written +=3D write_size;
>> +		}
>> +		copied +=3D read_size;
>> +	}
>> +	return ret;
>> +}
>> +
>>   static int process_clone(const char *path, u64 offset, u64 len,
>>   			 const u8 *clone_uuid, u64 clone_ctransid,
>>   			 const char *clone_path, u64 clone_offset,
>> @@ -788,8 +828,17 @@ static int process_clone(const char *path, u64 off=
set, u64 len,
>>   	ret =3D ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args);
>>   	if (ret < 0) {
>>   		ret =3D -errno;
>> -		error("failed to clone extents to %s: %m", path);
>> -		goto out;
>> +		if (ret !=3D -EINVAL || !rctx->clone_fallback) {
>> +			error("failed to clone extents to %s: %m", path);
>> +			goto out;
>> +		}
>> +
>> +		if (bconf.verbose >=3D 2)
>> +			warning(
>> +		"failed to clone extents to %s, fallback to buffered write",
>
> I think this message needs to tell the user how many bytes which they
> expected to be cloned are now being duplicated. Something like "failed
> to clone NNNNNN bytes to FILE, fallback to copying data".

Sure, that could help, and just like what Filipe mentioned, I'll also
add a summary for how many bytes in total are not cloned, after all
streams are received.

Thanks,
Qu

>
> Graham
>
>> +				path);
>> +		ret =3D buffered_copy(clone_fd, rctx->write_fd, clone_offset,
>> +				    len, offset);
>>   	}
>>
>>   out:
>> @@ -1197,6 +1246,8 @@ static const char * const cmd_receive_usage[] =3D=
 {
>>   	"                 this file system is mounted.",
>>   	"--dump           dump stream metadata, one line per operation,",
>>   	"                 does not require the MOUNT parameter",
>> +	"--clone-fallback when clone operations fail, attempt to directly cop=
y"
>> +	"                 the data instead"
>>   	"-v               deprecated, alias for global -v option",
>>   	HELPINFO_INSERT_GLOBALS,
>>   	HELPINFO_INSERT_VERBOSE,
>> @@ -1238,11 +1289,13 @@ static int cmd_receive(const struct cmd_struct =
*cmd, int argc, char **argv)
>>   	optind =3D 0;
>>   	while (1) {
>>   		int c;
>> -		enum { GETOPT_VAL_DUMP =3D 257 };
>> +		enum { GETOPT_VAL_DUMP =3D 257, GETOPT_VAL_CLONE_FALLBACK };
>>   		static const struct option long_opts[] =3D {
>>   			{ "max-errors", required_argument, NULL, 'E' },
>>   			{ "chroot", no_argument, NULL, 'C' },
>>   			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
>> +			{ "clone-fallback", no_argument, NULL,
>> +				GETOPT_VAL_CLONE_FALLBACK},
>>   			{ "quiet", no_argument, NULL, 'q' },
>>   			{ NULL, 0, NULL, 0 }
>>   		};
>> @@ -1286,6 +1339,9 @@ static int cmd_receive(const struct cmd_struct *c=
md, int argc, char **argv)
>>   		case GETOPT_VAL_DUMP:
>>   			dump =3D 1;
>>   			break;
>> +		case GETOPT_VAL_CLONE_FALLBACK:
>> +			rctx.clone_fallback =3D true;
>> +			break;
>>   		default:
>>   			usage_unknown_option(cmd, argv);
>>   		}
>>
>
