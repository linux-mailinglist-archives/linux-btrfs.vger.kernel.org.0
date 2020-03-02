Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6008175258
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 04:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCBDgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 22:36:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:59883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgCBDgV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 22:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583120175;
        bh=K3Q7fZxSSaM5qlJmYlcFI3kRlVKT+bED8bMD0n65+B8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:In-reply-to:Date;
        b=NpgKo4ea5n3rj/aYSzot/aII3kBtQVgG/9tM9RJCUck77o5U2WLcwjIMAYAheaCUC
         RizOu/nqJtDghg6SsLESUZkcia303aKzc2/h2tC9xOqYCoVcgCixnsDetPT360yBY0
         XoUpnbjQItQPoYiF1hYiwqrm0zyYcbWCfdal2YOc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p ([34.92.246.95]) by mail.gmx.com (mrgmx105 [212.227.17.174])
 with ESMTPSA (Nemesis) id 1MUGeB-1j0WsA2Kjz-00RKp5; Mon, 02 Mar 2020 04:36:15
 +0100
From:   Su Yue <Damenly_Su@gmx.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: disk-io: Kill the BUG_ON()s in write_and_map_eb()
References: <20200302014153.33122-1-wqu@suse.com>
User-agent: mu4e 1.2.0; emacs 26.3
In-reply-to: <20200302014153.33122-1-wqu@suse.com>
Date:   Mon, 02 Mar 2020 11:35:46 +0800
Message-ID: <m2r1ybctt9.fsf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Provags-ID: V03:K1:k9qzMLaeMiTLbnJozhns6UwzlNHA6OBLJHfdWtn2GjFpvjZP2P5
 6yMxRkfoTZAABHMc1Z0CID96mzRPYJ7f4qGy2mZWhdMAqo+1u6aidz/oQQx/vgUhCdEzcjh
 QPXv91YfA/v9EW/q/In6MRe8mPi/jBYAyvizlxPfwT/3UpXdJ4dszV4aVmbAGZkCGDNkLCY
 1cIa6wqB8lZXDX+a7qo2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3LWID83KpVc=:0hrwqEUh144vByWLksG5Db
 phdtX91M3CKCXeFTZ8vaX1LrqpEI+3kBelUl3u07M3eTuGsb9R3exPZX9Q9eXe/al0/8QpZbG
 zjPJrNNIpPLRoazfK0LmOfaHtPSMB1HlgD8zYLlbN74DvllF81sDM6rzTB4TJiU0vAX/qAWSZ
 S5NBx6NttAf+uSzycaIAzw13QkkKXWV3qMuj97hAlULdiidIdSbCDV9mm00zK6K5cy/QbPCns
 eCcEzzVIkCoyj6/9nQ87SUuD5LQlT/PWUNYGoaI5jGF5I9nGFYAWaUT7pLbM2/IWX6OAFdyCU
 D5NlFOUL4w2+O8uS63yTn+YBhf41Kez69aaaMufnS5meNTsf2KLeomCCN+b65lW/WvO79pJB5
 xBkiDbvZgxHczDoh3k3Ybl9/e1NgJNzy+wVcPxEkoq183J5CJ7KSl6N2gVClRvzKe9diR71NG
 +R7rPQZKaErRzQJOS59XxZZTNElnGx8fQnZAoFqbuoYI50PFosQm/ARgZ6ipXtNf3YLJ5p4Qh
 bYK2eWLfFmzc2VQoJD9qoNtuoOQNCNdxoLcTEJV0QFVbMrNzChKTCRfNRYIVMay0VGvQZzFTT
 lP5BwLDj3sJkxfDn6Ty+JevPz7ExnxR47q8nccoRWT3g6dmOGtFNmJjeXsIR45drz0rQ264em
 vtxX+0UT4v4/ZwYAMw5r/6uN4th8CEVH4fIly4+yh5ZgDKPE7RctagbvMSTWCqqZFrJH3Rsre
 zNdxKgXyXJno/3QXrabUKj16ANHkruKwMYIW5NB44J+W5uynFCSbMS6tZ0grnOosdBGarOz5K
 Zn6Ab/m/goROxe9OW/OIvNr5QVQ7oMGHVts0xPLRiOMcIOhCa3WLNpZS5DptZS4JAxTEnuvDw
 B5YzZTbVPTh8e6aWpRJ+PGTd9jBEgO7EsA70AfuDEpWaMEz2hh4OgEXGeOu9cE/B71gi0/+Ma
 MzpxGR5bCvYcCNsGuLPHu8pM2yQI0Ja+USarOvTRknn8UWhBEW13TJMOQIJv+mX5fV+PT+d75
 TqXR5vOKtSKr3IK6kQMU66Av84bjksXdCmfmDRuqs41mfK00/WHcB4OkOcJ0SOookLzxdQS5g
 JhfKTGQbxzGj/64/ECu2nqHMiXo02asUfBhdp9Sv2QxtOUBX5MXtAdPu07HVfV+x68AI3rM56
 FwRuF9pknWkz+Kocn47GLrUYIsVghdNVQlpp42H8QcOLPgoVld3JyXVRv1T0EX5G6Ea3OqLdO
 +pswCjdg+OCXjJboa
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 02 Mar 2020 at 09:41, Qu Wenruo <wqu@suse.com> wrote:

> All callers of write_and_map_eb(), except btrfs-corrupt-block,
> have handled error, but inside write_and_map_eb() itself, the
> only error handling is BUG_ON().
>
> This patch will kill all the BUG_ON()s inside
> write_and_map_eb(), and enhance the the caller in
> btrfs-corrupt-block() to handle the error.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com> ---
>  btrfs-corrupt-block.c       |  9 ++++++++-
>  cmds/rescue-super-recover.c |  3 ++-

So may the subject be prefixed with "btrfs-progs"?

>  disk-io.c                   | 26 +++++++++++++++++++++++--- 3
>  files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c index
> 95df871a7822..3c236e146176 100644 --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c @@ -771,8 +771,15 @@ static int
> corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
>  		u64 bogus =3D generate_u64(orig);
>  btrfs_set_header_generation(eb, bogus);
> -		write_and_map_eb(fs_info, eb); +		ret =3D
> write_and_map_eb(fs_info, eb);
>  		free_extent_buffer(eb);
> +		if (ret < 0) { +			errno =3D -ret; +
> fprintf(stderr, +				"failed to write extent buffer at
> %llu: %m", +				eb->start); +			return ret; +
> }
>  		break; } case BTRFS_METADATA_BLOCK_SHIFT_ITEMS:
> diff --git a/cmds/rescue-super-recover.c
> b/cmds/rescue-super-recover.c index 5d6bea836c8b..62f4f7754720
> 100644 --- a/cmds/rescue-super-recover.c +++
> b/cmds/rescue-super-recover.c @@ -276,7 +276,8 @@ int
> btrfs_recover_superblocks(const char *dname,
>  				  struct super_block_record, list);  root =3D
>  open_ctree(record->device_name, record->bytenr,
> -			  OPEN_CTREE_RECOVER_SUPER | OPEN_CTREE_WRITES); +
> OPEN_CTREE_RECOVER_SUPER | OPEN_CTREE_WRITES | +
> OPEN_CTREE_EXCLUSIVE);

Any explanation about this change?

Thanks

>  	if (!root) {
>  		ret =3D 3;
>  		goto no_recover;
> diff --git a/disk-io.c b/disk-io.c
> index e8a2e4afa93a..9ff62fcd54d1 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -487,20 +487,40 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info=
, struct extent_buffer *eb)
>  	length =3D eb->len;
>  	ret =3D btrfs_map_block(fs_info, WRITE, eb->start, &length,
>  			      &multi, 0, &raid_map);
> +	if (ret < 0) {
> +		errno =3D -ret;
> +		error("failed to map bytenr %llu length %u: %m",
> +			eb->start, eb->len);
> +		goto out;
> +	}
>
>  	if (raid_map) {
>  		ret =3D write_raid56_with_parity(fs_info, eb, multi,
>  					       length, raid_map);
> -		BUG_ON(ret);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			error(
> +		"failed to write raid56 stripe for bytenr %llu length %llu: %m",
> +				eb->start, length);
> +			goto out;
> +		}
>  	} else while (dev_nr < multi->num_stripes) {
> -		BUG_ON(ret);
>  		eb->fd =3D multi->stripes[dev_nr].dev->fd;
>  		eb->dev_bytenr =3D multi->stripes[dev_nr].physical;
>  		multi->stripes[dev_nr].dev->total_ios++;
>  		dev_nr++;
>  		ret =3D write_extent_to_disk(eb);
> -		BUG_ON(ret);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			error(
> +"failed to write bytenr %llu length %u devid %llu dev_bytenr %llu: %m",
> +				eb->start, eb->len,
> +				multi->stripes[dev_nr].dev->devid,
> +				eb->dev_bytenr);
> +			goto out;
> +		}
>  	}
> +out:
>  	kfree(raid_map);
>  	kfree(multi);
>  	return 0;

