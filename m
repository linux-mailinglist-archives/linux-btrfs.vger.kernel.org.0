Return-Path: <linux-btrfs+bounces-3314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB387C47F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 21:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C901F21319
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1701076400;
	Thu, 14 Mar 2024 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bjAQTAM/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA3763F3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449801; cv=none; b=LsVZBR+YbF2UmDekqyMd7hp3w0e5DKUmzhqVCanX3cdIdar8bIt/rSG/TIv/YqESoMWvvjTAe34FpgbBFo0qk2BT20RPndDNH2+iX05QHrBJ30Q2fFgRukMAZpO0ZYIsJ2u9Nnbu2NT82VvZnZK9/Kv3jUn+D0FDRQ+k2k+xjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449801; c=relaxed/simple;
	bh=enkrrLXrSBESeUH+IhHcGrSPrPFkLWeRgr3HN7vxDko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mk9st/DQalXGFSaTpZDsmhDPhhMLVyzbPwF4o4Ih4tqthZ81qyIt+UPKmtAo4Xta+RMexIGsj2YosNCm079QEBKhgQHNnYhOGqlO2CI8tlwpXFWYt7M+tY1hjHB1TlJAKsFojrNObXF8mzANESPueslraK50fUzNLDWCayvTxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bjAQTAM/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so1135001fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710449797; x=1711054597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pnz/smKMH8y2vb9mbgcFWE48zmLW/BhEfgrOodpMW/I=;
        b=bjAQTAM/DYPcdDJ0blfI1op52x04MoiT0GdP3AAxThWu7yE3UgqbBl05CKqNhv+1wr
         Nxn1SNABVO4aRVA/RPjNrhS4zCwe4eHnXwLZJpNDv/djfHdZSaw6Kdzc4wh5ZlmZCi8+
         XqT9yGrAURqkYC4JIG3t2cfWC04IL6ZmCpaE5UE+YLoryLTl0cz49+u0++w/fZcpOz4d
         jMhzZ/oE4jV4BocpdhkVCS9AMonMR161+2fa9UWNGdNgq+ro+4jKb59dbG8disIwgUie
         2TbFFqfP1hkekndRc73XiqmOCZVogjFwrycPritRlYbj5GFw9TpVo8B/Ut3/wWg3dBTH
         +0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449797; x=1711054597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnz/smKMH8y2vb9mbgcFWE48zmLW/BhEfgrOodpMW/I=;
        b=xSs3oa6mlCerKec1q0dk6VljAdQWfGcTIAMnhjLnVgF3EHNN3+7HnVlWiJ5qqJoO5Z
         CXR4xZ9KSjYHDzkkBeC+CS3XrN4isWvdXiKx3oDl/ieoiaCi0jV6oErTOBnhvj1mNQD3
         BKTOhcJxVTsw2w5FZwF9LlZXIxWVFFcWnz8VeKOsiQxlvfO7xz31m5lv8QuCrTTTi/mx
         n+EUfXz85YWbcZ3kPBTvq3LId2wWwGDllTbZyIC+zkpUiTIBWgE3EG/Tnzffa+FvVXT6
         //E52TI0B3mm61vbZ8v/9yDR7RHJB6bj10YFLqN5JMS+/OQIm96u4kegrHZRVtqDtEAR
         TbhQ==
X-Gm-Message-State: AOJu0YyfazOKsLcWG2p5z3jgtc5vsTotudBxVx85M5Gmg+eiVBguTzEJ
	v2OfDWSVO/3eDAaTIewY47lKIo+dTKT7DRPqyzRlGfXN7JXCZT72Va/G3P+E0Bo=
X-Google-Smtp-Source: AGHT+IEcVbVmRPyjjEq8ls2zF201+vdZpckjFGm0Qj83lVextd6sDxHFhW2P1JgW+rts1193hbmbcQ==
X-Received: by 2002:a2e:6a02:0:b0:2d2:6ed5:e45a with SMTP id f2-20020a2e6a02000000b002d26ed5e45amr1723113ljc.12.1710449796599;
        Thu, 14 Mar 2024 13:56:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b001dd528d63dcsm2197751pld.22.2024.03.14.13.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 13:56:36 -0700 (PDT)
Message-ID: <a645407f-4308-48cf-9c7b-6a2e5fc8501e@suse.com>
Date: Fri, 15 Mar 2024 07:26:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
 <CAL3q7H7wLB4wp+H-BYv1zi0ReywAJ2aiKf7LWyysb2rH44BZfg@mail.gmail.com>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAL3q7H7wLB4wp+H-BYv1zi0ReywAJ2aiKf7LWyysb2rH44BZfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/15 04:10, Filipe Manana 写道:
> On Thu, Mar 14, 2024 at 9:51 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Currently the scrub error report is pretty long:
>>
>>   BTRFS error (device dm-2): unable to fixup (regular) error at logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
>>   BTRFS warning (device dm-2): checksum error at logical 13647872 on dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 16384, length 4096, links 1 (path: file1)
>>
>> Since we have so many things to output, it's not a surprise we got long
>> error lines.
>>
>> To make the lines a little shorter, and make important info more
>> obvious, change the unify output to something like this:
>>
>>   BTRFS error (device dm-2): unable to fixup (regular) error at logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
>>   BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
> 
> I find that hard to read because:
> 
> 1) Please leave spaces before opening parenthesis.
>     That makes things less cluttered and easier to the eyes, more
> consistent with what we generally do and it's the formal way to do
> things in English (see
> https://www.scribens.com/grammar-rules/typography/spacing.html);

Yep, I can do that, but I also want to keep the involved members 
together thus closer.

Not sure if adding spaces would still keep the close relationships 
between the values.

E.g: inode 5/256 (file1) fileoff 16384, logical 123456 (1) physical 1 
(scratch1) 123456

It makes it a little harder to indicate that "(1)" is related to logical 
address (thus mirror number).

> 
> 2) Instead of "inode 5/257(file1)", something a lot easier to
> understand like "inode 5 root 257 path \"file1\"", which leaves no
> margin for doubt about what each number is;
> 
> 3) Same with "logical 13647872(1)" - what is the 1? That will be the
> question anyone reading such a log message will likely have.
>      Something like "logical 13647872 mirror 1" makes it clear;
> 
> 4) Same with "physical 1(/dev/mapper/test-scratch1)13647872".
>      Something like "physical 13647872 device ID 1 device path
> \"/dev/mapper/test-scratch1\"", makes it clear what each number is and
> easier to read.

I totally understand the original output format is much easier to read 
on its own.

However if we have hundreds lines of similar output, it's a different 
story, a small change in any of the value is much harder to catch, and 
the extra helpful prompt is in fact a burden other than a bless.

(That's why things like spreadsheet is much easier to reader for 
multiple similarly structured data, and in that case it's much better to 
craft a script to convert the lines into a csv)

Unfortunately we don't have the benefit (at least yet) to structure all 
these info into a structured output.


But what I'm doing here is to reduce the prompts to minimal (at most 4 
prompts, "inode", "fileoff", "logical", "physical"), so less duplicated 
strings for multiple lines of similar error messages.

The patchset is in the middle ground between fully detailed output (the 
old one, focusing on single line) and the fully script orient output (no 
prompt at all, just all numbers/strings, focusing on CSV like output).


Furthermore, I would also argue that, for entry level end users, they 
can still catch the critical info (like file path and device path) 
without much difficult, and those info is enough for them to take action.
(E.g. deleting the file, or replace the disk)

Yes, they would get confused on the devid or rootid, but that's fine and 
everyone can learn something new.

For experienced users who understand basics of btrfs, or us developers, 
the split in values are already arranged in a way similar sized values 
are never close together (aka, string/large/small value split).

Thanks,
Qu

> 
> Thanks.
> 

