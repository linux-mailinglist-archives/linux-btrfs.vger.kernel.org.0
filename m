Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F593C3DCF
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGKQHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKQHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 12:07:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA675C0613DD
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 09:05:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bt15so3516080pjb.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KWXI5KZYPqGF2NfUtiE2lpfxjCHVJN2nsmqRy25BwfE=;
        b=GjFon094vNmKDhdkjsyRkznLx63kXawCLyh1WR42Yl2cU51U36fP+sZGnUB16A2mS/
         zr/3fMRTyyDYNC7lpRjnOyS9mNN8EEyUr+B2hs+Z2D0PrhF0X721QyVLwHDcx8GidoeP
         1fguoniqUT1yKrsrwkUXqjEy6Y8nfNi3yW2sgniR7xPdR8msPUyGgHDNvRKYMAyy2QAT
         K9QKYYYLhRxJ6O1xxXK6tlL4Mz47MdoUY9QPRzk4qlJGE36DIZtvs1JV3KjiuDQOlvhi
         7wuFI/liZiEASYfzKhgs+dp+KurgmFczaHh4qPVmIHN8Rx4VuNUFqh7DBfByn0YpcTEM
         lRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KWXI5KZYPqGF2NfUtiE2lpfxjCHVJN2nsmqRy25BwfE=;
        b=aAMw1B/Ct77tiT33lZv8gy8dm0/KzPqs2kvEy8XiP2Y9aS4UJBNZLxAj+kiahZT0iL
         iSjsvJlSDC/RP9zd4O3xnwxm3TWzD+0ta3fcKTQMBH+rEO7pQfQwmxgxK4UHRXHP8r/g
         gMWKjEM64rr1I6OdvBtAez+uxhBcQFxtvfesb7Cj7hBaAYl4b89fHosZco2GKPpBEsdf
         sO+p4yvKP4IMi0nMV7FgCsx+AMgn2cpiyAmf2KX0tAyqei83AGi+GSLnFM3OvNYSPXA+
         8oK4lEuo8wscP473l2auYLgCKQJ4JrUHJMjVLz6RB1vd65pOftITcwui0YqC4jzu3h/t
         6Cvw==
X-Gm-Message-State: AOAM530NNw1moGymUUFdmxAhWiZPt+Jjd7pitvuq3Hk2vDookEaS+1Ny
        HiMUej8GY9Q7pJvfaSRTS/0=
X-Google-Smtp-Source: ABdhPJzk0S6a0npsmfk1YN6gMXsr+DfIxT7C/xQako2qJENG69i9MvMfALmVdTjuafj+2FDtzF8SWA==
X-Received: by 2002:a17:90a:17c1:: with SMTP id q59mr48370514pja.231.1626019500355;
        Sun, 11 Jul 2021 09:05:00 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id w14sm10750537pjb.3.2021.07.11.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:05:00 -0700 (PDT)
Date:   Sun, 11 Jul 2021 16:04:53 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC] btrfs-progs: cmds: Add subcommand that dumps file extents
Message-ID: <20210711160453.GA68357@realwakka>
References: <20210710144107.65224-1-realwakka@gmail.com>
 <8f248d54-ec4d-9a53-840f-6d162de14267@gmx.com>
 <1d679d44-c608-8d51-32d9-84c15d636e33@gmx.com>
 <20210711090247.GA66300@realwakka>
 <98e30ba5-9309-47d2-2ea7-37cfb2cddc3c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98e30ba5-9309-47d2-2ea7-37cfb2cddc3c@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 11, 2021 at 06:58:49PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/11 下午5:02, Sidong Yang wrote:
> > On Sun, Jul 11, 2021 at 09:33:43AM +0800, Qu Wenruo wrote:
> > 
> > Hi, I really thank you for review.
> > > 
> > > 
> > > On 2021/7/11 上午6:38, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2021/7/10 下午10:41, Sidong Yang wrote:
> > > > > This patch adds an subcommand in inspect-internal. It dumps file
> > > > > extents of
> > > > > the file that user provided. It helps to show the internal information
> > > > > about file extents comprise the file.
> > > > 
> > > > So this is going to be the combined command of filemap + btrfs-map-logical.
> > > > 
> > > > But how do you handle dirty pages which hasn't yet been flushed to disk?
> > 
> > I have no idea about this. Is there any references to get dirty pages
> > information?
> 
> For dirty pages there is no way to know their file extent info.
> Until we write them back.
> 
> This is delayed allocation utilized by all modern filesystem, and is one
> of the core concept to improve filesystem performance.
> 
> If you want to dig into the idea deeper, I would recommend to see how
> btrfs_buffered_write() works.
> It just does space reservation and copy the data to page cache, then
> call it all day.
> 
> The real writeback happen when extent_writepages() happens, which then
> allocate real on-disk file extents and emit the IO.
> 
> 
> For the dirty page writeback part, you can check the common
> fiemap_prep() function in fs/ioctl.c.
> 
> If we have FIEMAP_FLAG_SYNC, then it will inform the filesystem to
> writeback the inode before calling the fs specific fiemap code.
> 
> With that FIEMAP_FLAG_SYNC flag, then it's pretty much the same behavior
> of your draft, it just cares what's already in the subvolume tree,
> ignore the dirty pages completely.
> 
> And in btrfs, extent_fiemap() function in fs/btrfs/extent_io.c, is doing
> the main work.
> 
> It's mostly the enhanced version of your draft, but convert the output
> to fiemap ioctl format, with extra work like merging extents if possible.
> 
> It would be a pretty educational experience to read the code, as it's
> not that complex.

Yeah, I'm reading the code you said. It helps me to understand
filesystem. Thanks for detailed guide!

> 
> [...]
> > > 
> > > 
> > > OK, so you're doing on-disk file extent search.
> > > 
> > > This is fine, but under most case fiemap ioctl would be enough, not to
> > > mention fiemap can also handle pages not yet written to disk (by writing
> > > them back though).
> > 
> > It would be better that this patch also can do it.
> 
> But since the fiemap ioctl currently can't report the real size of
> compressed data, it can be sometimes pretty confusing to read the fiemap
> result.
> 
> E.g.:
> 
> # mount /dev/test/test  -o compress /mnt/btrfs/
> # xfs_io -f -c "pwrite 0 1M" /mnt/btrfs/file
> # sync
> # xfs_io  -f -c "fiemap -v" /mnt/btrfs/file
> /mnt/btrfs/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..255]:        26624..26879       256   0x8
>    1: [256..511]:      26632..26887       256   0x8
>    2: [512..767]:      26640..26895       256   0x8
>    3: [768..1023]:     26648..26903       256   0x8
>    4: [1024..1279]:    26656..26911       256   0x8
>    5: [1280..1535]:    26664..26919       256   0x8
>    6: [1536..1791]:    26672..26927       256   0x8
>    7: [1792..2047]:    26680..26935       256   0x9
> 
> Note the 0x8 flag, which indicates FIEMAP_EXTENT_ENCODED, and in btrfs
> it means it's compressed.
> But it can't show any btrfs specific info, the compression algorithm,
> nor the compressed size.
> 
> And the final one, has one extra bit 0x1, which means FIEMAP_FLAG_LAST,
> means it's the last extent of the file.
> 
> 
> But if you check the result more carefully, you will find that the
> ranges are overlapping.
> This is the limitation of current fiemap ioctl, it always assume every
> extent has the same size on-disk, thus causing above overlapping layout.

I understood. I checked disk_bytenr and disk_num_bytes on my patch. And
the output wasn't overlapped.

> 
> That's what your draft can do better, but personally speaking, I would
> prefer to enhance the fiemap ioctl other than creating a btrfs specific
> interface.

I agree. Maybe many filesystem has a problem about this.
> 
> > 
> > > 
> > > Although this manual search provides much better info for compressed
> > > extent, but unfortunately here you didn't do any extra handling for them.
> > 
> > It also good to show compression information.
> > 
> > > 
> > > Thus so far this is no better than fiemap to get the logical bytenr.
> > > 
> > > And I can't be more wrong, by thinking you're also doing the chunk
> > > lookup, which you didn't.
> > Sorry, I'm confused. Is it needed to do the chunk lookup?
> 
> No, it's me getting confused by the "physical" words.
> 
> You don't need to do that at all.
> 
> > > 
> > > So I don't see any benefit compared to regular fiemap.
> > > 
> > > In fact, fiemap can provide more info than your initial draft.
> > > Fiemap can already show if the map is compressed (but can't show the
> > > compressed size yet).
> > > 
> > > Your draft can be improved to:
> > > 
> > > - Show the compression algorithm
> > >    Which fiemap can't
> > > 
> > > - Show the compressed size
> > >    Which fiemap can't either.
> > > 
> > I understand that the point is that this command is nothing better than
> > fiemap ioctl now. but It can be improved by showing more information
> > that fiemap doesn't provide like compression algorithm.
> 
> Yes, but as mentioned, it would be better to enhance fiemap ioctl to do
> more work.
> 
> It may be acceptable as a debug tool for a while, but a generic
> interface would be the ultimate solution.
> 
> > > 
> > > > > +                case BTRFS_FILE_EXTENT_PREALLOC:
> > > > > +                    len = le64_to_cpu(extent_item->num_bytes);
> > > > > +                    physical = le64_to_cpu(extent_item->disk_bytenr);
> > > > > +                    physical_len =
> > > > > le64_to_cpu(extent_item->disk_num_bytes);
> > > > > +                    offset = le64_to_cpu(extent_item->offset);
> > > > > +                    printf("end = 0x%llx, physical = 0x%llx,
> > > > > physical_len = 0x%llx\n",
> > > 
> > > Currently we only use %llx for flags, for bytenr we always %llu.
> > > You could refer to print-tree.c to see more examples.
> > Thanks! I'll fix this.
> > > 
> > > And I don't really like the word "physical" here.
> > > 
> > > In fact the bytenr are all btrfs logical bytenr, which makes no direct
> > > sense for its physical location on disk.
> > Yeah, the word "physical" is not good. would It be better to write as
> > "disk_bytenr"?
> 
> That would be really much better, then it completely follows the naming
> in file extent item.

Thanks for kind comments. I'll write the next version.

Thanks,
Sidong

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Sidong
> > > 
> > > For real physical bytenr, we need something like (device id, physical
> > > offset), and needs to do a chunk map lookup.
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > > +                           begin + len, physical, physical_len);
> > > > > +                    break;
> > > > > +                }
> > > 
> > > > > +
> > > > > +            }
> > > > > +            buf_off += sizeof(*header) +
> > > > > btrfs_search_header_len(header);
> > > > > +            pos += len;
> > > > > +        }
> > > > > +
> > > > > +    }
> > > > > +    ret = 0;
> > > > > +out:
> > > > > +    close(fd);
> > > > > +    return ret;
> > > > > +}
> > > > > +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
> > > > > diff --git a/cmds/inspect.c b/cmds/inspect.c
> > > > > index 2ef5f4b6..dfb0e27b 100644
> > > > > --- a/cmds/inspect.c
> > > > > +++ b/cmds/inspect.c
> > > > > @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group = {
> > > > >            &cmd_struct_inspect_dump_tree,
> > > > >            &cmd_struct_inspect_dump_super,
> > > > >            &cmd_struct_inspect_tree_stats,
> > > > > +        &cmd_struct_inspect_dump_file_extents,
> > > > >            NULL
> > > > >        }
> > > > >    };
> > > > > 
