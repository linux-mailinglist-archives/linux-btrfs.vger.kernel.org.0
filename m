Return-Path: <linux-btrfs+bounces-19764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DACC026F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 00:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8092301B4A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 23:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F80329376;
	Mon, 15 Dec 2025 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CWhnAwXs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7327E06C
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839965; cv=none; b=LH+qqCZNOnppN7B5uf2qeTc4C3Xu8gJVx5HiPMEljA06+7bfIvl2i03YH2EJ794wKE021FvEEZNGwSbdt7vvg7F9u/XviZEWED/bn8nW5SlpRwsoezI4Z4O+W03EvUumdkMaMLTLciItPMPG29te6JRzsBXniDn9Yo+hgVE168s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839965; c=relaxed/simple;
	bh=1dopE7k/WUJ66wR5Dr/EmcB8sMb1sAKmngQwNbtKMaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy3kfezZItcVrDPrLsMCiOMJdvCX7Y/NISaEUNQ4wcMqKBnexkgQ0QaKXMkZ1BWKe2a3yfFl+0evSlmZWmgXaooEJvoR2sbbyRIBuSoJdhAAVmPgtA6Eu+W7zhlJog0GmwBeYSZJ1fIOma44vdqtHBqqqfSpnMlOTGH9/EmCorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWhnAwXs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so45060215e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765839960; x=1766444760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yno+zqvXG6cynHYgrXTXDAJ5Z3VgwtsCothQ23YERUI=;
        b=CWhnAwXsyozZhDpHShX0dJ3NzvpQ2BA9fYpoYr8QIK9bSuGqh5VRLRjbDtVF3KdBLV
         bWd5BJVgvUy41uYPMHnTWV+Q8nNq+lHar7X3X/dj0+6iIa9/aU8ix7vhcpL7sv+tt0Ft
         nB1TnzyyezX8SaBHumIHDTYO3OyJRA795uiduBEX/p26MkVC26vvQs0tWrfw5mZqA0Op
         YWyuPV1Pnkr91tIHwCt85AzEIS6dclzNbeFnW8ExN3FH+x+1IZdmRZCrux79NR9/yUIt
         VGF5nK1tbFv4nxN3kj+bSgn2jJOR3zXc6sMIAdryuz6UuEM/oIpM2Knm8MI6c2qzaVYZ
         iw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765839960; x=1766444760;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yno+zqvXG6cynHYgrXTXDAJ5Z3VgwtsCothQ23YERUI=;
        b=AqVoIe1pBCSWT+D8wIdg15uoD1X0DSCu9n826Hag248veG/56Zek0A84ZJhTgqgABg
         dOGp7Cm0xaa3XJ8uuuL/b44bc+DKbID2g6tW2JOHmoyCHhqLIHmVo1OJWkBJKU2iW5O5
         WAtI+KmiJyrNVnvIHs1p6M0HdzE15vvQqU0AG8p65n6NTNqsBAOcRbnZuwn4IZHLhGEo
         j2JhX7KQXf94Hf8c3ToR4FNEC7W2NMt1Wt/ZIYCU8f+ggYlzwpqvvHWlOuuLGwPOCeWP
         rsnVYO+qe3Om3geIgyHEd23XGQvQ+D79Abac2uZqSUBeTh6KQd1VrFNxlOJD1LFAWwE1
         kWJQ==
X-Gm-Message-State: AOJu0YzfFkv1tj3naAOU2iAmDlTMgVywJFF/aPBB1Qu0uJlwwmIZRKae
	zOi1hBzAvHA27soRXXiQg9xk+88mYdIqEyAwD8RD368+uykPkchrrtJpHsUBSXRfB1PgYF0cQz2
	q8r88QWc=
X-Gm-Gg: AY/fxX4MNOXpBRn11leYBvxGAZcLa/+R66cD2Ep6G7UdGiozaGK5toXGBxDXqDxDKln
	YG/VjIndwEaUUek9zVqJnq4EFmjvJfVNEjhYGmQYP6Il2XRoKk0bvKyrlwaDeieqEUyGAiL4ZWo
	YJ3DplZIA4+xlBC9rnyfPFNeFV60JGYtuo5LdtumjKwaO+DkDzS/Dafsxra18UxBK/IV5M7+NDe
	uJPFIEfaEesEcnlGMMmkDj/KIPO5qiI1PxijwNo+VMbhunBhdumyEcgvS5CPibbCCwbd1KWD5aP
	ETa/d4S7KdXp+cYUy95mp2cws5Kefq/ANkE7QVcsHAM8bTK2ag7eSEXFhh4/OFepyUPm2llxmvY
	hq1cLOEvDB+A7H95w5BSGNn2J0vfiDLr01DlPkBY4swR8xNYp3eRMPuEUpECPaojKBTBoyEM3/s
	NPc7YRGU95SR2sDiFgYs38njfHVGgtrYSjwM8wb+U=
X-Google-Smtp-Source: AGHT+IHAP3kR8dQ6PwN+dndWaYnsvA5eJzT1z6GRwqs53CrrhwumTb/NjePlurijonZDyQe0+m5WaA==
X-Received: by 2002:a05:600c:5494:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47a942cc100mr108886305e9.28.1765839959780;
        Mon, 15 Dec 2025 15:05:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a110f6374asm28351835ad.63.2025.12.15.15.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 15:05:59 -0800 (PST)
Message-ID: <4960584d-eb14-40ee-a039-c1ca27f20a05@suse.com>
Date: Tue, 16 Dec 2025 09:35:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at
 fs/btrfs/inode.c:4297 __btrfs_unlink_inode, forced readonly
To: mikkel+btrfs@mikkel.cc, lists@colorremedies.com
Cc: linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
References: <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
 <acefecca-9fbb-4268-a26a-b889756019e7@mikkel.cc>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <acefecca-9fbb-4268-a26a-b889756019e7@mikkel.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/16 08:31, Mikkel Jeppesen 写道:
> Hi there. Affected user here :)
> 
> On Monday, December 15, 2025 3:47:13 PM Central European Standard Time 
> Chris
> 
> Murphy wrote:
> 
>  > ...
> 
>  > >> Looks like --repair changed from "errors 4" to "errors 6"
> 
>  > >>
> 
>  > >>
> 
>  > >> [1/8] checking log
> 
>  > >> [2/8] checking root items
> 
>  > >> [3/8] checking extents
> 
>  > >> [4/8] checking free space tree
> 
>  > >> [5/8] checking fs roots
> 
>  > >>
> 
>  > >> unresolved ref dir 1924 index 0 namelen 40 name
> 
>  > >> AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 6, no dir
> 
>  > >> index, no inode ref>
> 
>  > > And repair again?
> 
>  >
> 
>  > No change.
> 
>  >
> 
>  > sudo btrfs-image -t 16 -c 9 -ss /dev/sda3 fs_post_repair.img
> 
>  >
> 
>  > https://paste.mikkel.cc/gNwpLmyw
> 
>  >
> 
>  > > If after repair, readonly check still shows error, I can craft a quick
> 
>  > > fix branch for the reporter.
> 
>  >
> 
>  > I'll check to see if they still have the file system. I asked them to 
> make a
> 
>  > btrfs-image before starting over. Thanks Qu!
> 
> I installed a new F43 install on a different SSD, so I still have the 
> affected
> 
> file system/install available for any testing.

Thanks a lot. If your fs doesn't contain confidential info in the file 
names (btrfs-image dump doesn't contain regular data, but may still 
contain inlined data), a regular btrfs-image dump would be the best way 
for us to test.

Unfortunately this corruption involves filename, thus the "-s"/"-ss" 
option is screwing up the result.


If there is confidential filenames involved, please provide the 
following dump from the original fs:

# btrfs ins dump-tree <device> | grep -C 7 
"AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E"

And unfortunately we will need to communicate for each new dump, so this 
will take some time.

And before posting the content of above dump, make sure no confidential 
filename is involved.

Thanks,
Qu

> 
> Thanks for the quick and good responses to this! :)
> 


